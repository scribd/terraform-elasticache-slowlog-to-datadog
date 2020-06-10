locals {
  slowlog_check_archive_basename = "slowlog_check.1.3.0-alpha.1.zip"
  slowlog_check_archive_hash     = "LLpRWQaZYLhSbHthcbFq6se2MV1K9qH6p+oeZd/miVw="
  slowlog_check_archive_path     = "${path.module}/files/${local.slowlog_check_archive_basename}"

  search_replication_group    = "(?P<first>[0-9A-Za-z_-]+)\\.(?P<second>[0-9A-Za-z_-]+)\\.{0,1}(?P<third>[0-9A-Za-z_]*)\\.(?P<region>[0-9A-Za-z_-]+)\\.cache\\.amazonaws\\.com:{0,1}(?P<port>[0-9]*)"
  parsed_elasticache_endpoint = regex(local.search_replication_group, var.elasticache_endpoint)
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Endpoints.html
  replication_group = contains(["clustercfg", "master"], local.parsed_elasticache_endpoint["first"]) ? local.parsed_elasticache_endpoint["second"] : local.parsed_elasticache_endpoint["first"]
}
