variable "region" {
    default = "ap-northeast-2"
}

variable "azs" {
    description = "A list of availability zones of ids in th region"
    type = list(string)
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "cluster_name" {
    description = "cluster name"
    type = "string"
    default = null
}

variable "vpc_cidr" {
    description = "vpc cidr range"
    type = string
    default = "null"
}

variable "vpc_name" {
    description = "vpc name"
    type = string
    default = "null"
}

variable "cluster_version" {
    description = "cluster version"
    type = string
    default = "1.28"
}