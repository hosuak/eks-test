# outputs.tf
output "vpc_id" {
    description = "The ID of the VPC"
    value = aws_vpc.SA_TEST_VPC.id
}

output "eks_subnets" {
    description = "List of IDs of all subnets"
    value = [aws_subnet.test-2a-public-subnet.id, aws_subnet.test-2c-public-subnet.id]
}

output "public_subnets" {
    description = "List of IDs of all subnets"
    value = [aws_subnet.test-2a-public-subnet.id, aws_subnet.test-2c-public-subnet.id, aws_subnet.test-2a-private-subnet.id, aws_subnet.test-2c-private-subnet.id]
}

output "private_subnets" {
    description = "List of IDs of all subnets"
    value = [aws_subnet.test-2a-private-subnet.id, aws_subnet.test-2c-private-subnet.id]
}
