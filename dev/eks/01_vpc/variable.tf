variable "region" {
    type = string
    default = "ap-northeast-2"
}

variable "azs" {
    description = "A list of availability zones of ids in th region"
    type = list(string)
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "cluster_name" {
    description = "cluster name"
    type        = string
    default     = "test-eks"
}

