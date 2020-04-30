resource aws_cloudwatch_event_rule slowlog_check {
  name_prefix         = "slowlog_check_every_minute"
  description         = "Check for slowlogs every minute"
  schedule_expression = "rate(1 minute)"
  tags                = var.tags
}

resource aws_cloudwatch_event_target slowlog_check {
  rule = aws_cloudwatch_event_rule.slowlog_check.name
  arn  = aws_lambda_function.slowlog_check.arn
}

resource aws_lambda_permission slowlog_check {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slowlog_check.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.slowlog_check.arn
}


resource aws_iam_role slowlog_check {
  name = "slowlog_check"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource aws_iam_policy slowlog_check {
  name        = "slowlog_check"
  path        = "/"
  description = "This IAM policy allows the slowlog_check to run"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
            "ssm:GetParameter",
            "ssm:GetParametersByPath"
          ],
          "Resource": [
            "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.ssm_path}",
            "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.ssm_path}/*"
            ],
          "Effect": "Allow"
        }
    ]
}
EOF
}

resource aws_iam_role_policy_attachment "lambda_vpc_0" {
  role       = aws_iam_role.slowlog_check.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource aws_iam_role_policy_attachment "lambda_vpc_1" {
  role       = aws_iam_role.slowlog_check.name
  policy_arn = aws_iam_policy.slowlog_check.arn
}

resource aws_security_group egress {
  name_prefix = "egress-https"
  description = "Allow outbound https calls"
  vpc_id      = var.vpc_id

  # https://github.com/hashicorp/terraform/issues/8617#issuecomment-343973544-permalink
  lifecycle {
    create_before_destroy = true
  }

  egress {
    description = "outbound https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource null_resource get_slowlog_check_archive {
  triggers = {
    exists = fileexists(local.slowlog_check_archive_path) ? filebase64sha256(local.slowlog_check_archive_path) : local.slowlog_check_archive_hash
  }
  provisioner local-exec {
    command     = "wget https://github.com/scribd/elasticache-slowlog-to-datadog/releases/download/v${local.slowlog_check_archive_version}/${local.slowlog_check_archive_basename}"
    working_dir = path.module
  }
}

resource aws_ssm_parameter datadog_api_key {
  name        = "/${var.ssm_path}/DATADOG_API_KEY"
  description = "Datadog API Key"
  tags        = var.tags
  type        = "SecureString"
  value       = var.datadog_api_key
}

resource aws_ssm_parameter datadog_app_key {
  name        = "/${var.ssm_path}/DATADOG_APP_KEY"
  description = "Datadog App Key"
  tags        = var.tags
  type        = "SecureString"
  value       = var.datadog_app_key
}


resource "aws_lambda_function" "slowlog_check" {
  function_name    = "slowlog_check"
  filename         = local.slowlog_check_archive_path
  source_code_hash = local.slowlog_check_archive_hash
  role             = aws_iam_role.slowlog_check.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "ruby2.5"
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = concat([aws_security_group.egress.id], var.elasticache_security_groups)
  }
  timeout = 600

  environment {
    variables = {
      REDIS_HOST = var.elasticache_endpoint
      SSM_PATH   = "${var.ssm_path}"
      NAMESPACE  = var.namespace
      ENV        = var.env
      METRICNAME = var.metric_name
    }
  }

  tags       = var.tags
  depends_on = [null_resource.get_slowlog_check_archive]
}

resource aws_lambda_function_event_invoke_config slowlog_check {
  function_name          = aws_lambda_function.slowlog_check.function_name
  maximum_retry_attempts = 0
}
