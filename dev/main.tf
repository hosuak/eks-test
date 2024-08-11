terraform {
  required_providers {    # 필요한 제공자(provider) 지정
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region                 = "ap-northeast-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
