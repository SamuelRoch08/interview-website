output "task_def_name" {
  value = aws_ecs_task_definition.service.family
}

output "task_def_arn" {
  value = aws_ecs_task_definition.service.arn
}

output "task_def_revision" {
  value = aws_ecs_task_definition.service.revision
}