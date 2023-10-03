# Creating a cluster Role and attach an existing, AWS Policy to it
resource "aws_iam_role" "eks-cluster-role" {
  count = var.kubernetes-enabled ? 1 :0

  name = "EKSClusterRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "cluster-policy-to-eks-cluster-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role[0].name
}