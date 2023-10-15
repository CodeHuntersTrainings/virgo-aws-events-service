resource "aws_rds_cluster_instance" "codehunters-rds-cluster-instance" {
  count = var.database-enabled ? 1 :0 # 1 = master

  cluster_identifier    = aws_rds_cluster.codehunters-rds-cluster[0].cluster_identifier
  instance_class        = "db.t3.medium" # //AWS cli: aws rds describe-orderable-db-instance-options --engine aurora-postgresql --engine-version 15.3 --query "OrderableDBInstanceOptions[].{DBInstanceClass:DBInstanceClass,SupportedEngineModes:SupportedEngineModes[0]}" --output table --region eu-central-1
  engine                = aws_rds_cluster.codehunters-rds-cluster[0].engine
  engine_version        = aws_rds_cluster.codehunters-rds-cluster[0].engine_version
  apply_immediately     = true
  db_subnet_group_name  = aws_db_subnet_group.codehunters-rds-cluster-subnet-group[0].name
  # performance_insights_enabled = true
}