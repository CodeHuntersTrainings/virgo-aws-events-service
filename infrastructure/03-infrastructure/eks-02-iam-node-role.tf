# Creating a node group Role and attach an existing, AWS Policy to it
resource "aws_iam_role" "eks-node-group-role" {
  count = var.kubernetes-enabled ? 1 :0

  name = "EKSNodeGroupRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node-policy-to-eks-node-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role[0].name
}

