##### BUCKET #####
resource "aws_s3_bucket" "terraform-state-s3bucket" {
  bucket = "codehunters.terraform.state.bucket"
}

#resource "aws_s3_bucket_versioning" "terraform-state-s3bucket-versioning" {
#  bucket = aws_s3_bucket.terraform-state-s3bucket.id
#  versioning_configuration {
#    status = "Enabled"
#  }
#}

##### SETTING UP ENCRYPTION #####
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state-s3bucket-kms" {
  bucket = aws_s3_bucket.terraform-state-s3bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}
