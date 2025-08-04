resource "aws_security_group" "lb_sg" {
  name        = "${var.project_name}-lb-sg"
  description = "SG for ${var.project_name} LB"
  vpc_id      = data.aws_subnet.deploy_subnet.vpc_id
  tags        = var.extra_tags
}

resource "aws_security_group_rule" "lb_port_ingress" {
  type              = "ingress"
  from_port         = var.listener_port
  to_port           = var.listener_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "lb_port_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

module "s3_logs" {
  source = "../../storage/s3"
  count  = var.enable_lb_access_logging ? 1 : 0

  bucket_name   = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-${var.project_name}-lb-logs"
  force_destroy = true
}

resource "aws_lb_target_group" "tg" {
  name                 = "${var.project_name}-lb-alb-tg"
  target_type          = "instance"
  protocol             = "HTTP"
  vpc_id               = data.aws_subnet.deploy_subnet.vpc_id
  deregistration_delay = 60
  port                 = var.listener_port

  load_balancing_algorithm_type = "round_robin"
  tags                          = var.extra_tags
}

resource "aws_lb" "lb" {
  name               = "${var.project_name}-alb"
  internal           = var.is_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.lb_subnets

  dynamic "access_logs" {
    for_each = var.enable_lb_access_logging ? [0] : []
    content {
      bucket  = module.s3_logs[0].bucket_id
      enabled = true
    }

  }
  tags = var.extra_tags
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
  port = var.listener_port
  tags = var.extra_tags
}