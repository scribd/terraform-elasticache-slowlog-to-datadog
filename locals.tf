locals {
  slowlog_check_archive_basename = "slowlog_check.3.0.5.zip"
  slowlog_check_archive_hash     = filebase64sha256("${path.module}/files/${local.slowlog_check_archive_basename}")
  slowlog_check_archive_path     = "${path.module}/files/${local.slowlog_check_archive_basename}"

  # https://pythex.org/?regex=(%3FP%3Cfirst%3E%5B0-9A-Za-z_-%5D%2B)%5C.(%3FP%3Csecond%3E%5B0-9A-Za-z_-%5D%2B)%5C.%7B0%2C1%7D(%3FP%3Cthird%3E%5B0-9A-Za-z_%5D*)%5C.%7B0%2C1%7D(%3FP%3Cfourth%3E%5B0-9A-Za-z_%5D*)%5C.(%3FP%3Cregion%3E%5B0-9A-Za-z_-%5D%2B)%5C.cache%5C.amazonaws%5C.com%3A%7B0%2C1%7D(%3FP%3Cport%3E%5B0-9%5D*)&test_string=cluster-one.abcdef.0001.use1.cache.amazonaws.com%3A6379%0Acluster-two.abcdef.ng.0001.use1.cache.amazonaws.com%3A6379%0Amaster.cluster-three.abcdef.use1.cache.amazonaws.com%3A6379%0A&ignorecase=0&multiline=0&dotall=0&verbose=0
  search_replication_group    = "(?P<first>[0-9A-Za-z_-]+)\\.(?P<second>[0-9A-Za-z_-]+)\\.{0,1}(?P<third>[0-9A-Za-z_]*)\\.{0,1}(?P<fourth>[0-9A-Za-z_]*)\\.(?P<region>[0-9A-Za-z_-]+)\\.cache\\.amazonaws\\.com:{0,1}(?P<port>[0-9]*)"
  parsed_elasticache_endpoint = regex(local.search_replication_group, var.elasticache_endpoint)
  # https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Endpoints.html
  replication_group = contains(["clustercfg", "master"], local.parsed_elasticache_endpoint["first"]) ? local.parsed_elasticache_endpoint["second"] : local.parsed_elasticache_endpoint["first"]
}
