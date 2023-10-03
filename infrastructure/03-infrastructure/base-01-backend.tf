terraform {
  backend "s3" {
    bucket         = "codehunters.terraform.state.bucket"
    key            = "codehunters.demo.terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "dynamodb-terraform-state-locking"
  }
}
