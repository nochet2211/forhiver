terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.50"
    }
  }
}
provider "aws" {
  region = var.region
}