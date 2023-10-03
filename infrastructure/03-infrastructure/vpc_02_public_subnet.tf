##### PUBLIC SUBNET #####
resource "aws_subnet" "public-subnets" {
  count = var.vpc-enabled ? length(var.public-subnets) : 0

  vpc_id                    = aws_vpc.vpc[0].id
  cidr_block                = element(var.public-subnets, count.index)
  availability_zone         = element(var.availability-zones, count.index)

  map_public_ip_on_launch   = true

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_route_table" "route-table-public-subnets" {
  count = var.vpc-enabled ? 1 :0

  vpc_id = aws_vpc.vpc[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway[0].id
  }

  tags = {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "route-table-association-public" {
  count = var.vpc-enabled ? length(var.public-subnets) : 0

  subnet_id         = aws_subnet.public-subnets[count.index].id
  route_table_id    = aws_route_table.route-table-public-subnets[0].id
}

##### NAT GW must be deployed into the public subnet #####
resource "aws_eip" "nat_gw_eip" {
  count = var.vpc-enabled && var.nat-gw-enabled ? 1 :0

  domain = "vpc" # Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc).
}

resource "aws_nat_gateway" "nat-gateway-eu-central-1a" {
  count = var.vpc-enabled && var.nat-gw-enabled ? 1 :0

  allocation_id = aws_eip.nat_gw_eip[0].id
  subnet_id     = aws_subnet.public-subnets[0].id
}