data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "origin_bucket" {
  bucket = var.main_bucket_name
}

data "aws_s3_bucket" "log_bucket" {
  count  = var.use_log_bucket ? 1 : 0
  bucket = var.log_bucket_name
}

data "aws_s3_bucket" "failover_bucket" {
  count  = var.use_failover_bucket ? 1 : 0
  bucket = var.failover_bucket_name
}
