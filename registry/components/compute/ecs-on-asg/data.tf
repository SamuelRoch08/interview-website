data "aws_region" "current" {}

data "aws_ami" "ecs_ami" {
  most_recent = true
  name_regex  = "^al2023-ami-ecs-hvm-2023.*x86_64"
  owners      = ["amazon", "aws-marketplace"]
}

data "aws_subnet" "app_a_subnet" {
  id = var.cluster_subnet_ids[0]
}