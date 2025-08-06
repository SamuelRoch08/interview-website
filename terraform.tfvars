# Define variable values here
primary_region   = "eu-west-1"
secondary_region = "us-east-1"
profile          = "sandbox"

webapp1_config = {
  name           = "webapp-on-ecs"
  src_code       = "./src/webapp-on-ecs/"
  container_name = "httpd"
}

webapp2_config = {
  name      = "webapp-on-s3"
  src_code  = "./src/webapp-on-s3/react-app/"
  deploy_dr = true
}