terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 6.7.0"
      configuration_aliases = [aws.dr]
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.4"
    }
  }
}

