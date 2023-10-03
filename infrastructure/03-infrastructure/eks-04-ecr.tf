# Node group role gets Read Only access to ECR
resource "aws_iam_role_policy_attachment" "ecr-read-only-to-eks-node-group-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role[0].name
}