output "distribution_id" {
  value       = aws_cloudfront_distribution.distribution.id
  description = "Distribution ID"
}

output "distribution_arn" {
  value       = aws_cloudfront_distribution.distribution.arn
  description = "Distribution ARN"
}

output "distribution_dns" {
  value       = aws_cloudfront_distribution.distribution.domain_name
  description = "Distribution DNS"
}