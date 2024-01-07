terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  // Store state file remotely.
  backend "s3" {
    bucket = "tfstate-myEKS-100"
    key    = "backend/myEKS-VPC.tfstate"
    region = "ap-south-1"
    dynamodb_table = "remote-backend-myEKS"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}