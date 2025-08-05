resource "aws_iam_role" "task_exec_role" {
  name = "${var.project_name}-${var.container_name}-${data.aws_region.current.region}-execrole"
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = var.extra_tags
}

resource "aws_iam_role_policy_attachment" "task_exec_role" {
  role       = aws_iam_role.task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "service" {
  family = "${var.project_name}-${var.container_name}"
  cpu    = var.task_cpu
  memory = var.task_mem
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image_uri
      essential = true
      portMappings = [
        {
          appProtocol   = "http"
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.task_exec_role.arn

  runtime_platform {
    cpu_architecture        = var.cpu_arch
    operating_system_family = var.os_family
  }

  tags = var.extra_tags
}
