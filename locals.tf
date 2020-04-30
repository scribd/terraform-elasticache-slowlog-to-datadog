locals {
  slowlog_check_archive_version  = "1.0.1"
  slowlog_check_archive_hash     = "Xn5bMbrSmVqdHMjchEAk/r2TJT6cHdQfIXRIaZo7vdQ=" # generated with filebase64sha256()
  slowlog_check_archive_basename = "slowlog_check.${local.slowlog_check_archive_version}.zip"
  slowlog_check_archive_path     = "${path.module}/${local.slowlog_check_archive_basename}"
}
