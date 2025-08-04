# Define your provider here 

terraform {
  required_version = ">=1.12.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.6.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.4"
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
  profile = var.profile

  default_tags {
    tags = {
      "Owner"   = "Samuel Rochcongar"
      "Project" = "WebApp"
    }
  }
}

provider "aws" {
  alias   = "aws-dr"
  region  = var.secondary_region
  profile = var.profile

  default_tags {
    tags = {
      "Owner"   = "Samuel Rochcongar"
      "Project" = "WebApp"
    }
  }
}
