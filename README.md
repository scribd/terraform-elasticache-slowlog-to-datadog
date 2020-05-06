# terraform_elasticache_slowlog_to_datadog

**Deploy Elasticache Slowlog to Datadog lambda function to AWS account**

This terraform module deploys [elasticache-slowlog-to-datadog](https://github.com/scribd/elasticache-slowlog-to-datadog)
to AWS so that slowlog entry metrics can be submitted to Datadog. 

![Release](https://github.com/scribd/terraform-elasticache-slowlog-to-datadog/workflows/Release/badge.svg)
[![terraformregistry](https://img.shields.io/badge/terraform-registry-blueviolet)](https://registry.terraform.io/modules/scribd/slowlog-to-datadog/elasticache)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

# Usage

```
module slowlog_check {
  source                      = "git::https://github.com/scribd/terraform-elasticache-slowlog-to-datadog.git?ref=master"
  elasticache_endpoint        = "master.replicationgroup.abcdef.use2.cache.amazonaws.com"
  elasticache_security_groups = ["sg-12345"]
  subnet_ids                  = [ "subnet-0123456789abcdef", "subnet-abcdef1234567890", "subnet-1234567890abcdef", ]
  vpc_id                      = "vpc-0123456789abcdef"
  datadog_api_key             = "abc123"
  datadog_app_key             = "abc123"
  namespace                   = "example"
  env                         = "dev"
  tags                        = {"foo" = "bar"}
}
```

## Parameters

The following parameters need to be supplied to the terraform job

Parameter                   | Type         | Description                                                                  | Required | Default
----------------------------|--------------|------------------------------------------------------------------------------|----------|---------
elasticache_endpoint        | string       | AWS Elasticache endpoint to get slowqueries from                             | yes      | -
elasticache_security_groups | list(string) | AWS Elasticache Security groups to bind to                                   | yes      | []
subnet_ids                  | list(string) | Subnets to associate with VPC lambda job                                     | yes      | -
vpc_id                      | string       | VPC to associate with VPC lambda job                                         | yes      | -
datadog_api_key             | string       | Datadog API key                                                              | yes      | -
datadog_app_key             | string       | Datadog App key                                                              | yes      | -
namespace                   | string       | Namespace tag to pass to datadog                                             | yes      | -
env                         | string       | Namespace tag to pass to datadog                                             | yes      | -
metric_name                 | string       | Custom metric name to pass ot datadog                                        | no       | "elasticache.slowlog"
ssm_path                    | string       | Custom SSM path to provision Datadog access ID's in. Leading slash ommitted. | no       | "slowlog_check"
tags                        | object       | Additional tags to create resources with and to send to datadog              | no       | {}

# Requirements

To use *terraform-elasticache-slowlog-to-datadog* you need:

- An AWS account with an Elasticache instance running the `redis5.0` engine.
- A Datadog account

# Development

Releases are cut using [semantic-release](https://github.com/semantic-release/semantic-release).

Please write commit messages following [Angular commit guidelines](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines)
