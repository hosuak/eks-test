
variable "cluster_version" {
  type    = string
  default = "1.33"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "name_prefix" {
  type    = string
  default = "test"
}

variable "public_subnet_a_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_c_cidr" {
  type    = string
  default = "10.0.2.0/24"
}