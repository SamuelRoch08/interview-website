resource "aws_ecs_service" "service" {
  name                 = var.service_name
  cluster              = var.ecs_cluster_arn
  task_definition      = var.task_def_arn
  desired_count        = var.desired_count
  iam_role             = var.task_arn_role != "" ? var.task_arn_role : null
  launch_type          = var.launch_type
  force_new_deployment = true

  ordered_placement_strategy {
    type  = var.placement_strategy
    field = var.placement_strategy == "spread" ? "instanceId" : (var.placement_strategy == "binpack" ? "cpu" : null)
  }

  dynamic "load_balancer" {
    for_each = var.lb_target_group_arn != "" ? [0] : []
    content {
      target_group_arn = var.lb_target_group_arn
      container_name   = var.lb_container_name
      container_port   = var.lb_container_port
    }
  }
}
