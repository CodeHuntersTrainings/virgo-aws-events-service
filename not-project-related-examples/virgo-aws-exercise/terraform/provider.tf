terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Setup your credential files to make this work
  profile   = "default"
  region    = "eu-central-1"
}