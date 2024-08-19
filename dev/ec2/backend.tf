# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# The block below configures Terraform to use the 'remote' backend with Terraform Cloud.
# For more information, see https://www.terraform.io/docs/backends/types/remote.html
terraform {
  cloud {

    organization = "testing_eks"  # terraform organization 등록

    // terraform workspace 등록
    workspaces {
      name = "eks-test"
    }
  }

  required_version = ">= 1.1.2"
}
