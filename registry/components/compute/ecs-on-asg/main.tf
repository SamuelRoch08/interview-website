## Role for EC2 in the cluster 
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
# Policy required for ECS 
resource "aws_iam_role_policy_attachment" "ecs_for_role" {
  role       = aws_iam_role.ec2_role_for_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
# Additional Policy for SSM access
resource "aws_iam_role_policy_attachment" "ssm_for_role" {
  role       = aws_iam_role.ec2_role_for_ecs.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_role_for_ecs" {
  name = aws_iam_role.ec2_role_for_ecs.name
  role = aws_iam_role.ec2_role_for_ecs.name
}

# Simple cloudwatch Log group where to write cluster logs 
resource "aws_cloudwatch_log_group" "cluster" {
  name              = "${var.cluster_name}-logs"
  retention_in_days = 14
  tags              = var.extra_tags
}

# Cluster SG attached to Cluster ec2 - With default rules for inbound and outbound 
resource "aws_security_group" "cluster" {
  name        = "${var.cluster_name}-sg"
  description = "SG for nodes inside ${var.cluster_name} ECS cluster"
  vpc_id      = data.aws_subnet.app_a_subnet.vpc_id

  tags = merge(var.extra_tags, {
    Name = "${var.cluster_name}-sg"
  })
}

resource "aws_security_group_rule" "outbound_all" {
  security_group_id = aws_security_group.cluster.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_http" {
  security_group_id = aws_security_group.cluster.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "ingress"
  cidr_blocks       = var.allowed_inbound_cidr
}

# The cluster itself 
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

# The launch template that will be used by the ASG and, in fine, the Cluster 
resource "aws_launch_template" "cluster" {
  name_prefix            = "${var.cluster_name}-lt"
  image_id               = "ami-08c9a28b806bde705" # al2023-ami-ecs-hvm-2023.0.20250730-kernel-6.1-x86_64
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.cluster.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_role_for_ecs.name
  }
  # We chose spot for pricing reason here 
  instance_market_options {
    market_type = "spot"
  }
  instance_initiated_shutdown_behavior = "terminate"

  # Usage of template files to simplify the user data management 
  user_data = base64encode(templatefile("${path.module}/userdata.sh.tftpl", {
    cluster_name = aws_ecs_cluster.cluster.name
  }))
}

# ASG to manage EC2 instance for cluster 
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

  tag {
    key                 = "Name"
    value               = "${aws_ecs_cluster.cluster.name}-ec2"
    propagate_at_launch = true
  }

}

# The capacity provider that is using the ASG 
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

# Link between Cluster <-> Cluster Provider <-> ASG 
resource "aws_ecs_cluster_capacity_providers" "cluster" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = [aws_ecs_capacity_provider.cluster.name]
}


