output "ecr_name" {
  description = "ECR name."
  value       = aws_ecr_repository.ecr.name
}

output "ecr_url" {
  description = "ECR URL."
  value       = aws_ecr_repository.ecr.repository_url
}

output "ecr_id" {
  description = "ECR Id."
  value       = aws_ecr_repository.ecr.registry_id
}