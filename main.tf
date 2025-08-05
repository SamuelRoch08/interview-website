# All kind of resources
module "interview_webapp1" {
  source = "./registry/app/webapp-on-ecs-asg"

  webapp_name     = "webapp-on-ecs"
  webapp_src_code = "${path.cwd}/src/webapp-on-ecs/"
  container_name  = "httpd"

  providers = {
    aws           = aws
    aws.secondary = aws.dr
  }
}

module "interview_webapp2" {
  source = "./registry/app/webapp-on-s3-cdn"

  profile          = var.profile
  webapp_name      = "webapp-on-s3"
  webapp_src_code  = "${path.cwd}/src/webapp-on-s3/react-app/"
  secondary_region = var.secondary_region
  deploy_dr        = true

  providers = {
    aws    = aws
    aws.dr = aws.dr
  }
}
