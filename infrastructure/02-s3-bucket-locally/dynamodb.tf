resource "aws_dynamodb_table" "state_locking" {
  name     = "dynamodb-terraform-state-locking"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
