terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 6.7.0"
      configuration_aliases = [aws.secondary]

    }
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.6.2"
    }
  }
}

