
# Create a VPC
resource "aws_vpc" "test" {
  cidr_block = var.vpc_cidr

  # VPC에서 DNS 지원을 활성화/비활성화(default = true)
  enable_dns_support = "true"
  # VPC에서 DNS 호스트 이름을 활성화/비활성화(default = true)
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "${var.aws_region}a"

  # 이 서브넷에서 인스턴스 생성시 퍼블릭 IP도 자동 할당
  # Public Subnet의 필수 설정
  map_public_ip_on_launch = true


  # "shared" 값은 해당 리소스(예: 서브넷, 보안그룹 등)가 여러 클러스터와 공유될 수 있음을 의미
  # 만약 값이 "owned"라면, 해당 리소스가 특정 클러스터에 소유됨을 의미
  # 이 태그를 붙이면 EKS 클러스터에서 VPC, 서브넷, 보안그룹 등을 자동으로 찾고 관리 가능
  tags = {
    Name                                            = "${var.name_prefix}-public-a"
    "kubernetes.io/role/elb"                        = "1"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.public_subnet_c_cidr
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true


  # "shared" 값은 해당 리소스(예: 서브넷, 보안그룹 등)가 여러 클러스터와 공유될 수 있음을 의미
  # 만약 값이 "owned"라면, 해당 리소스가 특정 클러스터에 소유됨을 의미
  # 이 태그를 붙이면 EKS 클러스터에서 VPC, 서브넷, 보안그룹 등을 자동으로 찾고 관리 가능
  tags = {
    Name                                            = "${var.name_prefix}-public-c"
    "kubernetes.io/role/elb"                        = "1"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}


# 트래픽 경로(mapping) 정의
# 각 서브넷(subnet)은 반드시 하나의 라우트 테이블과 연결(association)되어야 하며,
# 이 라우트 테이블에 정의된 대로 트래픽이 라우팅
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name_prefix}-public-rt"
  }
}

# 서브넷은 라우트 테이블과 연결되어야만 라우트 테이블의 규칙이 적용
# 실제로 어떤 서브넷/게이트웨이에 그 테이블 규칙을 적용할지 지정
# 올바르게 assocition하지 않으면, 트래픽이 의도한 대로 흐르지 않거나 인터넷 접근이 막힐 수 있음.
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}