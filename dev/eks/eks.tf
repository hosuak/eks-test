# # eks.tf

# data "aws_caller_identity" "current" {}

# # locals는 테라폼 내에서 복잡한 계산이나 조합을 미리 수행해 결과를 저장해 두고, 이를 코드 내에서 여러 번 재사용하기 위해 사용
# # 계정 ID를 포함한 다른 값을 쉽게 참조하기 위해 사용
# locals {
#     node_group_name = "${var.cluster_name}"
#     iam_role_policy_pretex = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy"
# }

# module "eks" {
#     source = "terraform-aws-modules/eks/aws"

#     cluster_name = var.cluster_name
#     cluster_version = var.cluster_version
    
#     cluster_endpoint_private_access = true
#     cluster_endpoint_public_access = true

#     vpc_id = module.vpc.vpc_id
#     subnet_ids = module.vpc.private_subnets
# }