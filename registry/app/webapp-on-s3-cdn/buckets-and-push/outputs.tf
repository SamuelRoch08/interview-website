output "main_bucket" {
  value = module.s3.bucket_name
}

output "main_bucket_id" {
  description = "Name of the bucket"
  value       = module.s3.bucket_id
}

output "main_bucket_arn" {
  value       = module.s3.bucket_arn
  description = "ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
}
output "main_bucket_dns" {
  value       = module.s3.bucket_dns
  description = "Bucket domain name. Will be of format bucketname.s3.amazonaws.com"
}

output "main_bucket_regional_dns" {
  value       = module.s3.bucket_regional_dns
  description = "The bucket region-specific domain name. The bucket domain name including the region name"
}

output "log_bucket" {
  value = module.s3_logs.bucket_name
}

output "log_bucket_arn" {
  value       = module.s3_logs.bucket_arn
  description = "ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
}