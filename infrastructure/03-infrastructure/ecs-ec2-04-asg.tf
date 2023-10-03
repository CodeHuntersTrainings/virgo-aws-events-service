# We need to create an autoscaling group that defines the minimum, the maximum, and the desired EC2 instances count.

resource "aws_autoscaling_group" "ecs-asg" {
  count = var.ecs-enabled ? 1 :0

  name_prefix = "codehunters_asg_"

  termination_policies = [
    "OldestInstance"
  ]

  default_cooldown          = 30
  health_check_grace_period = 30
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  launch_configuration      = aws_launch_configuration.ecs-config-launch-config[0].name

  lifecycle {
    # Required to redeploy without an outage.
    create_before_destroy = true
  }

  # A list of vpc SUBNET IDs are needed
  vpc_zone_identifier = aws_subnet.private-subnets.*.id

}