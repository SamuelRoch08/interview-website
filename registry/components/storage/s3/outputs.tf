output "bucket_id" {
  description = "Name of the bucket"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
}
output "bucket_dns" {
  value       = aws_s3_bucket.bucket.bucket_domain_name
  description = "Bucket domain name. Will be of format bucketname.s3.amazonaws.com"
}

output "bucket_regional_dns" {
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
  description = "The bucket region-specific domain name. The bucket domain name including the region name"
}

output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "The bucket name."
}