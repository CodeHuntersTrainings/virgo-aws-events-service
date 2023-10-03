resource "aws_subnet" "private-subnets" {
  count = var.vpc-enabled ? length(var.public-subnets) : 0

  vpc_id              = aws_vpc.vpc[0].id
  cidr_block          = element(var.private-subnets, count.index)
  availability_zone   = element(var.availability-zones, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_route_table" "route-table-private-subnet" {
  count = var.vpc-enabled && var.nat-gw-enabled ? 1 :0

  vpc_id            = aws_vpc.vpc[0].id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-gateway-eu-central-1a[0].id
  }

  tags = {
    Name = "Private Subnet Route Table"
  }
}

resource "aws_route_table_association" "route-table-association-private" {
  count = var.vpc-enabled && var.nat-gw-enabled ? length(var.private-subnets) : 0

  subnet_id       = aws_subnet.private-subnets[count.index].id
  route_table_id  = aws_route_table.route-table-private-subnet[0].id
}