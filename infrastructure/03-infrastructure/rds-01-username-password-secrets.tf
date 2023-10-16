# Source for Random Provider: https://medium.com/cloudnloud/random-provider-in-terraform-950134f9fe86

resource "random_string" "rds-username" {
  count = var.database-enabled ? 1 :0

  length  = 8
  special = false
  upper   = false
}

resource "random_password" "rds-password" {
  count = var.database-enabled ? 1 :0

  length  = 16
  special = false
  upper   = false
}

resource "aws_secretsmanager_secret" "rds-secrets" {
  count = var.database-enabled ? 1 :0

  name = "codehunters-aurora-secrets-v7"
}

resource "aws_secretsmanager_secret_version" "rds-secrets-version" {
  count = var.database-enabled ? 1 :0

  secret_id = aws_secretsmanager_secret.rds-secrets[0].id

  secret_string = <<EOF
   {
    "username": "${random_string.rds-username[0].result}",
    "password": "${random_password.rds-password[0].result}"
   }
  EOF
}
