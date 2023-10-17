resource "aws_vpc_endpoint" "sqs-endpoint" {
  count = var.queue-enabled ? 1 : 0 # 1 = master

  vpc_id                = aws_vpc.vpc[0].id
  service_name          = "com.amazonaws.eu-central-1.sqs"
  vpc_endpoint_type     = "Interface" # Gateway Endpoint is supported for S3 and DynamoDB only
  private_dns_enabled   = true

  security_group_ids    = [ aws_security_group.subnet-security-group[0].id ]
  subnet_ids            = aws_subnet.private-subnets.*.id
}