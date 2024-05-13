terraform {
  required_version = "~> 1.0"
  # the configuration for this backend will be set by the GitHub Action


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.8.0, < 6.0.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}