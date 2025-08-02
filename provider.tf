# Define your provider here 

terraform {
  required_version = ">=1.12.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }

  backend "s3" {
    profile = "sandbox"
    bucket  = "srochcongar-eu-west-1-terraform-backend"
    key     = "project/sandbox/website/terraform.tfstate"
    region  = "eu-west-1"
  }
}

provider "aws" {
  region  = var.primary_region
  profile = "sandbox"

  default_tags {
    tags = {
      "Owner"   = "Samuel Rochcongar"
      "Project" = "WebApp"
    }
  }
}