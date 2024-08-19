# vpc.tf

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = var.vpc_name
    azs = var.azs
    cidr = var.vpc_cidr

    # Nat gw 생성
    enable_nat_gateway = true

    # Nat gw 1개 생성
    single_nat_gateway = true

    # 서브넷 자동생성 
    # 8:새로운 서브넷 마스크 길이(숫자 크면 서브넷 많이 생성/각각의 크기는 작아)  ex.cidrblock이 10.0.0.0/16이라면 /16에 8를 더해 /24 크기의 서브넷을 생성)
    # for index in range(2) : range(2)는 0부터 1까지 두번 반복을 의미. 각 반복에서 index 값을 0과 1로 바꿔가며 두개의 서브넷 생성
    # index+2 : 고유한 서브넷 생성(cidr subnet 나눠주기 위해 사용)
    public_subnets = [for index in range(2): cidrsubnet(var.vpc_cidr, 8, index)]
    private_subnets = [for index in range(2): cidrsubnet(var.vpc_cidr, 8, index+2)] 
}