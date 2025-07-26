data "aws_vpc" "test" {
  filter {
    name   = "tag:Name"
    values = ["${var.name_prefix}-vpc"]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name  = "tag:Name"
    values = ["${var.name_prefix}-public-a"]
  }
  vpc_id = data.aws_vpc.test.id
}

data "aws_subnet" "public_c" {
  filter {
    name  = "tag:Name"
    values = ["${var.name_prefix}-public-c"]
  }
  vpc_id = data.aws_vpc.test.id
}


