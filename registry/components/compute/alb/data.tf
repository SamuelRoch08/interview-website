data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_subnet" "deploy_subnet" {
  id = var.lb_subnets[0]
}