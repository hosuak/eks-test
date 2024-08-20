# main.tf

terraform {
  required_version = ">=1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "admin"   # AWS CLI 프로파일을 참조해 Terraform이 AWS에 접근할 떄 사용할 자격 증명을 지정하는 데 사용
}
