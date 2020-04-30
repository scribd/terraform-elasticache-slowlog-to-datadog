variable elasticache_endpoint {
  description = "AWS Elasticache endpoint to get slowqueries from"
}

variable elasticache_security_groups {
  description = "AWS Elasticache Security groups to bind to"
  type        = list(string)
  default     = []
}

variable subnet_ids {
  description = "Subnets to associate with VPC lambda job"
  type        = list(string)
}

variable vpc_id {
  description = "VPC to associate with VPC lambda job"
}

variable datadog_api_key {
  description = "Datadog API key"
}

variable datadog_app_key {
  description = "Datadog App key"
}

variable namespace {
  description = "Namespace tag to pass to datadog"
}

variable env {
  description = "Env tag to pass to datadog"
}

variable metric_name {
  description = "Custom metric name to pass to datadog"
  default     = "elasticache.slowlog"
}

variable ssm_path {
  description = "Custom SSM path to provision Datadog access ID's in. Leading slash ommitted. The final SSM paths will look like: `/$ssm_path/$elasticache_endpoint/DATADOG_API_KEY`"
  default     = "slowlog_check"
}

variable tags {
  description = "Additional tags to create resources with and to send to datadog"
  default     = {}
}
