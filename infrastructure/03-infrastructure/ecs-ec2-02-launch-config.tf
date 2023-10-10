# Before creating an autoscaling group, we need to create a launch configuration that defines
# what type of EC2 instances will be launched when scaling occurs.

resource "aws_launch_configuration" "ecs-config-launch-config" {
  count = var.ecs-enabled ? 1 :0

  name_prefix                 = "codehunters_ecs_cluster_"
  # This must be an ECS Optimized AMI (An AMI is a template that contains the software configuration (operating system, application server, and applications) required to launch your instance.)
  image_id                    = "ami-0b5009e7f102539b1"                 # https://eu-central-1.console.aws.amazon.com/ec2/home?region=eu-central-1#AMICatalog
  instance_type               = "t2.small"
  associate_public_ip_address = false

  # spot_price                = "0.0175" # hourly rate

  lifecycle {
    # Required to redeploy without an outage.
    create_before_destroy = true
  }

  user_data = <<EOF
      #!/bin/bash
      echo ECS_CLUSTER=${var.ecs-cluster-name} >> /etc/ecs/ecs.config
      EOF

  // Security Group !!
  security_groups         = [aws_security_group.subnet-security-group[0].id]
  iam_instance_profile    = aws_iam_instance_profile.ecs-agent-profile[0].arn
}