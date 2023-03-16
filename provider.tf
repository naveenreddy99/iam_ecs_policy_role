terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }

  backend "s3" {
    bucket  = "bucket-name"
    encrypt = true
    key     = "directory/terraform.tfstate"
    region  = "us-gov-west-1"
  }
}

provider "aws" {
  region = "us-gov-west-1"
}