terraform {
  backend "s3" {
    bucket       = "my-docker-bucket-1"
    key          = "prod/aws_docker"
    region       = "us-east-1"
    use_lockfile = true
  }
  required_version = "~>1.11.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.97.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}