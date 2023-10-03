# source: https://hands-on.cloud/terraform-aws-vpc-tutorial/

resource "aws_vpc" "vpc" {
  count = var.vpc-enabled ? 1 :0

  cidr_block            = "10.0.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    Name = "CodeHunters VPC"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  count = var.vpc-enabled && var.internet-gw-enabled ? 1 :0

  vpc_id                = aws_vpc.vpc[0].id
}

