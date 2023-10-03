# Before we launch the EC2 instances and register them into the ECS cluster,
# we have to create an IAM role and an instance profile to use when they are launched.
# Source: https://dev.to/thnery/create-an-aws-ecs-cluster-using-terraform-g80

data "aws_iam_policy_document" "ecs-agent-data" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-agent" {
  count = var.ecs-enabled ? 1 :0

  name               = "ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs-agent-data.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  count = var.ecs-enabled ? 1 :0

  role       = aws_iam_role.ecs-agent[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# We have to create an instance profile that attaches to the EC2 instances launched from the autoscaling group.
# An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance
# when the instance starts.
resource "aws_iam_instance_profile" "ecs-agent-profile" {
  count = var.ecs-enabled ? 1 :0

  name = "ecs-agent"
  role = aws_iam_role.ecs-agent[0].name
}