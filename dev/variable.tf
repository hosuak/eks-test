variable "region" {
  type        = string
  default     = "ap-northeast-2"
  description = "dev-region"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

