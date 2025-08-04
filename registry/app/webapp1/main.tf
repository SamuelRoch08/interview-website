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

module "ecr" {
  source       = "../../compute/ecr"
  repo_name    = "${var.webapp_name}-ecr"
  force_delete = true
}

resource "docker_image" "webapp_image" {
  name = "${module.ecr.ecr_url}:latest"
  build {
    context = var.webapp_src_code
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(var.webapp_src_code, "**") : filesha1("${var.webapp_src_code}/${f}")]))
  }
}

resource "docker_registry_image" "webapp" {
  name          = docker_image.webapp_image.name
  keep_remotely = true
}

