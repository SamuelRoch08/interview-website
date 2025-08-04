data "aws_region" "current" {}

data "aws_ecr_authorization_token" "ecr_token" {
  registry_id = module.ecr.ecr_id
}
