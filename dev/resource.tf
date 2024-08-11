resource "aws_eip" "test-eip" {
  instance = aws_instance.test-ec2.id
  domain = "vpc" 
  # vpc      = true   -> deprecated
}

resource "aws_eip_association" "test-eip-association" {
  instance_id   = aws_instance.test-ec2.id
  allocation_id = aws_eip.test-eip.id
}

resource "aws_instance" "test-ec2" {
  ami = "ami-045f2d6eeb07ce8c0"
  instance_type =var.instance_type
  subnet_id = aws_subnet.dev-2a-public-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.dev-web-sg.id]
  key_name = aws_key_pair.test_keypair.key_name

  tags = {
    Name = "eks-test-ec2"
  }
}

resource "null_resource" "configure-test-app" {
  depends_on = [aws_eip_association.test-eip-association]

  // triggers = {
  //   build_number = timestamp()
  // }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.sua_key.private_key_pem
      host        = aws_eip.test-eip.public_ip
    }
  }
}

resource "tls_private_key" "sua_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "test_keypair" { 
    key_name = "sua_key.pem"
    public_key = tls_private_key.sua_key.public_key_openssh
}

resource "local_file" "sua_key" {
    filename = "./.ssh/sua-key.pem"
    content = tls_private_key.sua_key.private_key_pem
}
