module "network_foundations" {
  source = "../../network/vpc-subnets-multi-az"

  network_name   = var.webapp_name
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  app_subnets    = var.app_subnets
  data_subnets   = var.data_subnets
  extra_tags     = var.wepapp_tags
}

module "ecs_cluster" {
  source = "../../compute/ecs-on-asg"

  cluster_name       = "${var.webapp_name}-cluster"
  cluster_subnet_ids = module.network_foundations.apps_subnets_ids
}