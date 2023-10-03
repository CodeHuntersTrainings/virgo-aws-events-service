# The cluster name is important here since we used it previously when creating the launch configuration.
# This ECS cluster is where newly created EC2 instances will register.

resource "aws_ecs_cluster" "ecs-cluster" {
  count = var.ecs-enabled ? 1 :0

  name  = var.ecs-cluster-name

  tags = {
    Name        = var.ecs-cluster-name
  }
}