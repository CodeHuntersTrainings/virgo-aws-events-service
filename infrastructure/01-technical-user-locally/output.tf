output "access_key_id" {
  value = aws_iam_access_key.terraform-service-user-access-key.id
}

output "secret_access_key" {
  value = aws_iam_access_key.terraform-service-user-access-key.secret
  sensitive = true
}