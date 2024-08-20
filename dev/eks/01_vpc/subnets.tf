# subnets.tf
resource "aws_subnet" "test-2a-utility-subnet" {
  vpc_id     = aws_vpc.SA_TEST_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.azs_[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "test-2a-utility-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "KubernetsCluster" = var.cluster_name
    "SubnetType" = "Utility"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "test-2c-utility-subnet" {
  vpc_id     = aws_vpc.SA_TEST_VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.azs_[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "test-2c-utility-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "KubernetsCluster" = var.cluster_name
    "SubnetType" = "Utility"
  }
}

resource "aws_subnet" "test-2a-private-subnet" {
  vpc_id     = aws_vpc.SA_TEST_VPC.id
  cidr_block = "10.0.10.0/24"
  availability_zone = var.azs_[0]

  tags = {
    Name = "test-2a-private-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "KubernetsCluster" = var.cluster_name
    "SubnetType" = "Private-eks"
    "kubernetes.io/role/internal-elb" = "1"
    # "karpenter.sh/discovery" = "test-eks-k8s"
  }
}

resource "aws_subnet" "dev-2c-private-subnet" {
  vpc_id     = aws_vpc.SA_TEST_VPC.id
  cidr_block = "10.0.20.0/24"
  availability_zone = var.azs_[1]

  tags = {
    Name = "test-2c-private-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "KubernetsCluster" = var.cluster_name
    "SubnetType" = "Private-eks"
    "kubernetes.io/role/internal-elb" = "1"
    # "karpenter.sh/discovery" = "test-eks-k8s"
  }
}
