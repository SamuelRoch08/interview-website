output "ecs_arn" {
  value = aws_ecs_cluster.cluster.arn
}

output "ecs_capacity_provider_arn" {
  value = aws_ecs_capacity_provider.cluster.arn
}