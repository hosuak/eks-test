module "eks_al2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.cluster_name}-al2"
  cluster_version = "1.28"

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  self_managed_node_groups = {
    example = {
      ami_type      = "AL2_x86_64"
      instance_type = "t3.medieum"

      min_size = 2
      max_size = 3
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2

      labels = {
        test = sua-eks
      }

    }
  }

# 인스턴스에 tag 추가
  tags = {
    "k8s.io/cluster-autoscaler/enabled" : "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" : "true"
  }
}