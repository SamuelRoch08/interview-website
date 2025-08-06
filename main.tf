# All kind of resources
module "interview_webapp1" {
  source = "./registry/app/webapp-on-ecs-asg"

  webapp_name     = var.webapp1_config.name
  webapp_src_code = "${path.cwd}/${var.webapp2_config.src_code}/"
  container_name  = var.webapp1_config.container_name

  providers = {
    aws           = aws
    aws.secondary = aws.dr
  }
}

module "interview_webapp2" {
  source = "./registry/app/webapp-on-s3-cdn"

  profile         = var.profile
  webapp_name     = var.webapp2_config.name
  webapp_src_code = "${path.cwd}/${var.webapp2_config.src_code}"
  deploy_dr       = var.webapp2_config.deploy_dr

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }
}
