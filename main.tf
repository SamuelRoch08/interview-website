# All kind of resources
module "interview_webapp" {
  source = "./registry/app/webapp1"

  webapp_name     = "webapp-on-ecs"
  webapp_src_code = "${path.cwd}/src/webapp-on-ecs/"
}