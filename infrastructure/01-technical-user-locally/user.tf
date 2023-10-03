##### USER #####
resource "aws_iam_user" "terraform-service-user" {
  name = "terraform.iam.user"
}

##### POLICIES #####
resource "aws_iam_user_policy_attachment" "iam-access" {
  user       = aws_iam_user.terraform-service-user.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_user_policy_attachment" "ec2-access" {
  user       = aws_iam_user.terraform-service-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "s3-access" {
  user       = aws_iam_user.terraform-service-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "rds-access" {
  user       = aws_iam_user.terraform-service-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_user_policy_attachment" "secrets-access" {
  user       = aws_iam_user.terraform-service-user.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_user_policy_attachment" "dynamodb-access" {
  user       = aws_iam_user.terraform-service-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

##### ACCESS KEYS #####
resource "aws_iam_access_key" "terraform-service-user-access-key" {
  user = aws_iam_user.terraform-service-user.name
}




