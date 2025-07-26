output "vpc_id" {
  value = aws_vpc.test.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_c.id]
}
