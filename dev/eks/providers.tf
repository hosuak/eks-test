provider "aws" {
    region = local.region
    profile = "admin"

    default_tags {
      tags= {
        Service = "test"
        Env = "dev"
        Terraformd = "true"
      }
    }
}

locals{
    name = "dev"
    cluster_version = "1.33"
    region = "ap-northeast-2"

    vpc_cidr = "10.0.0.0/16"
    azs = slice(data.aws_availability_zones.avaliable.names, 0, 3)

    tags = {
        User = admin
    }
}
