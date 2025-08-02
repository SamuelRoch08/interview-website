resource "aws_iam_role" "ec2_role_for_ecs" {
  name = "${var.cluster_name}-ec2-role"
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role_for_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


resource "aws_cloudwatch_log_group" "cluster" {
  name = "${var.cluster_name}-logs"
  retention_in_days = 14
  tags = var.extra_tags
}


resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name

  configuration {
    execute_command_configuration {
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.cluster.name
      }
      logging = "OVERRIDE"
    }
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.extra_tags
}


resource "aws_launch_template" "cluster" {
  name_prefix   = "${var.cluster_name}-lt"
  image_id      = "ami-03d2fcd553ebee199"
  instance_type = "t4g.micro"

  user_data = file("${path.module}/userdata.sh")


  instance_market_options {
    market_type = "spot"
  }
  instance_initiated_shutdown_behavior = "terminate"
}

resource "aws_autoscaling_group" "cluster" {

  max_size            = var.cluster_max_size
  min_size            = var.cluster_min_size
  vpc_zone_identifier = var.cluster_subnet_ids

  launch_template {
    id      = aws_launch_template.cluster.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_ecs_capacity_provider" "cluster" {
  name = "${aws_ecs_cluster.cluster.name}-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.cluster.arn

    managed_scaling {
      maximum_scaling_step_size = var.cluster_max_size
      minimum_scaling_step_size = var.cluster_min_size
      status                    = "ENABLED"
      target_capacity           = 2
      instance_warmup_period    = 60
    }
  }

  tags = var.extra_tags
}

