# vpc.tf
resource "aws_vpc" "SA_TEST_VPC" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true       # ec2가 퍼블릭 DNS 호스트 이름 자동으로 할당. 인스턴스에 연결 시 IP 주소 대신 도메인 이름 사용
  enable_dns_support = true         # VPC에서 DNS 지원을 활성화/비활성화하는 플래그 (기본값:ture)
  instance_tenancy = "default"

  tags = {
    Name = "SA_TEST_VPC"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"     # 해당 리소스가 여러 클러스터나 여러 서비스 간에 공유될 수 있음  <> owned : k8s 클러스터 전용으로 사용
  }
}