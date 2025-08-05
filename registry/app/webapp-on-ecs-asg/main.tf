module "app_main_region" {
  source = "./alb-ecs-network-service"

  webapp_name     = var.webapp_name
  webapp_src_code = var.webapp_src_code
  container_name  = var.container_name
  container_cpu   = 256
  container_mem   = 512
}

module "app_secondary_region" {
  source = "./alb-ecs-network-service"
  providers = {
    aws = aws.secondary
  }
  webapp_name         = var.webapp_name
  webapp_src_code     = var.webapp_src_code
  container_name      = var.container_name
  container_cpu       = 256
  container_mem       = 512
  cluster_max_size    = 1
  cluster_min_size    = 1
  cluster_target_size = 1
  app_subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.11.0/24", "10.0.12.0/24"]
  data_subnets        = ["10.0.21.0/24", "10.0.22.0/24"]
}

