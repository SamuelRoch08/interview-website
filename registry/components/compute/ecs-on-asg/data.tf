data "aws_region" "current" {}

data "aws_subnet" "app_a_subnet" {
  id = var.cluster_subnet_ids[0]
}