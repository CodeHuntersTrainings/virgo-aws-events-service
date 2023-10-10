resource "aws_s3_bucket" "events-store" {
  count = var.s3-enabled ? 1 :0

  bucket = "events-store"

  tags = {
    Name = "Events Store"
  }
}
