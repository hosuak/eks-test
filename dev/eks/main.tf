module "eks_al2023" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.16.0"

  cluster_name = local.name
  cluster_version = local.cluster_version
  # 클러스터 api-server에 대한 접근제어 
  # 운영환경에서는 false로 접근제한하는 것을 권장
  cluster_endpoint_public_access = true

  #####################
  # EKS Addons 
  #####################
  cluster_addons = {
    coredns = {
        most_recent = true
    }
    kube-proxy = {
        most_recent = true
    }
  }
  
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    karpenter = {
      name = "karpenter"
      instance_types = "t3.large"
        
      # 비용절감 목적
      capacity_type = "SPOT"
      min_size = 2
      max_size = 2
      desired_size = 2
      
      # Ref https://awslabs.github.io/amazon-eks-ami/nodeadm/doc/api/
      cloudinit_pre_nodeadm = [
        {
          content_type = "application/node.eks.aws"
          content      = <<-EOT
            ---
            apiVersion: node.eks.aws/v1alpha1
            kind: NodeConfig
            spec:
              kubelet:
                config:
                  shutdownGracePeriod: 30s
                  featureGates:
                    DisableKubeletCloudCredentialProviders: true
          EOT
        }
      ]
    }
  }
  tags = local.tags
}
