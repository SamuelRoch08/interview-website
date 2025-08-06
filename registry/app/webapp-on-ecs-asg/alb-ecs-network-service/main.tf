module "network_foundations" {
  source = "../../../components/network/vpc-subnets-multi-az"

  network_name      = var.webapp_name
  vpc_cidr          = var.vpc_cidr
  public_subnets     = var.public_subnets
  app_subnets       = var.app_subnets
  data_subnets      = var.data_subnets
  extra_tags        = var.wepapp_tags

}

module "ecs_alb" {
  source = "../../../components/compute/alb"

  project_name             = var.webapp_name
  is_internal              = true
  lb_subnets               = module.network_foundations.publics_subnets_ids
  enable_lb_access_logging = true
  listener_port            = var.app_listener_port
  listener_protocol        = var.app_listener_protocol
  extra_tags               = var.wepapp_tags
}

module "ecs_cluster" {
  source = "../../../components/compute/ecs-on-asg"

  cluster_name         = "${var.webapp_name}-cluster"
  cluster_subnet_ids   = module.network_foundations.apps_subnets_ids
  allowed_inbound_cidr = var.public_subnets
  cluster_max_size     = var.cluster_max_size
  cluster_min_size     = var.cluster_min_size
  cluster_target_size  = var.cluster_target_size
}

module "ecr" {
  source       = "../../../components/compute/ecr"
  repo_name    = "${var.webapp_name}-ecr"
  force_delete = true
}

# We base the image tag on the src code sha1. If we modify the code, the tag is modified, so the task def also and it updates the service (deploys the mew updated code)
resource "docker_image" "webapp_image" {
  name = "${module.ecr.ecr_url}:${substr(sha1(join("", [for f in fileset(var.webapp_src_code, "**") : filesha1("${var.webapp_src_code}/${f}")])), 0, 12)}"
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

module "task_definition" {
  source = "../../../components/compute/ecs-task-definition"

  project_name   = var.webapp_name
  container_name = var.container_name
  image_uri      = docker_image.webapp_image.name
  task_cpu       = var.container_cpu
  task_mem       = var.container_mem
  cpu_arch       = "X86_64"
}

module "service_deployment" {
  source = "../../../components/compute/ecs-service"

  project_name        = var.webapp_name
  service_name        = var.container_name
  ecs_cluster_arn     = module.ecs_cluster.ecs_arn
  task_def_arn        = module.task_definition.task_def_arn
  lb_target_group_arn = module.ecs_alb.target_group_arn
  lb_container_name   = var.container_name
  lb_container_port   = var.container_port
  deploy_min_per      = 50
  desired_count       = var.cluster_target_size
  force_deploy        = true
}

