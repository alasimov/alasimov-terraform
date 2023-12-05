terraform {
  required_version =  "~> 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.1"
    }
  }

  ##backend "s3" {}
}

provider "aws" {
  region = var.aws_region
  
  # assume_role {
  #   role_arn     = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_provider_role_name}"
  # }
}