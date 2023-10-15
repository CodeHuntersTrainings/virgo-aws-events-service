resource "aws_db_subnet_group" "codehunters-rds-cluster-subnet-group" {
  count = var.database-enabled ? 1 :0

  subnet_ids = aws_subnet.private-subnets.*.id
}

resource "aws_rds_cluster" "codehunters-rds-cluster" {
  count = var.database-enabled ? 1 :0

  engine                = "aurora-postgresql"
  engine_version        = "15.3"
  database_name         = "codehunters_user_events"
  master_password       = random_password.rds-password[0].result
  master_username       = random_string.rds-username[0].result

  deletion_protection           = false
  skip_final_snapshot           = true
  allow_major_version_upgrade   = true

  apply_immediately               = true
  # preferred_backup_window       = "???"
  # preferred_maintenance_window  = "???"

  iam_database_authentication_enabled = true
  vpc_security_group_ids = [ aws_security_group.subnet-security-group[0].id ]
  db_subnet_group_name = aws_db_subnet_group.codehunters-rds-cluster-subnet-group[0].name
}