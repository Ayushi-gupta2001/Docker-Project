terraform {
  backend "s3" {
    bucket       = "my-docker-bucket"
    key          = "prod/aws_docker"
    region       = "us-east-1"
    use_lockfile = true
  }
  required_version = "~>1.11.3"
  required_providers {
    aws = {
      source  = "hashicrop/aws"
      version = ">=5.90.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}