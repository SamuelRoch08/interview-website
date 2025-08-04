# All kind of resources
# module "interview_webapp1" {
#   source = "./registry/app/webapp1"

#   webapp_name     = "webapp-on-ecs"
#   webapp_src_code = "${path.cwd}/src/webapp-on-ecs/"
# }

module "interview_webapp2" {
  source = "./registry/app/webapp2"

  profile         = var.profile
  webapp_name     = "webapp-on-s3"
  webapp_src_code = "${path.cwd}/src/webapp-on-s3/react-app/"
}