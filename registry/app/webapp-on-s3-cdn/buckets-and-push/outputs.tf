output "main_bucket" {
  value = module.s3.bucket_name
}

output "log_bucket" {
  value = module.s3_logs.bucket_name
}