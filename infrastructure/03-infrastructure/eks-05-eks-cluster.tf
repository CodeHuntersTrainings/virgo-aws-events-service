# Terraform module: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
# Example: https://dev.to/aws-builders/creating-an-eks-cluster-and-node-group-with-terraform-1lf6

resource "aws_eks_cluster" "eks-cluster" {
  count = var.kubernetes-enabled ? 1 :0

  name     = "codehunters-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-role[0].arn

  vpc_config {
    subnet_ids          = aws_subnet.private-subnets.*.id
    security_group_ids  = [ aws_security_group.subnet-security-group[0].id ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-policy-to-eks-cluster-role
  ]
}

data "aws_eks_cluster_auth" "eks-cluster-auth" {
  count = var.kubernetes-enabled ? 1 :0
  depends_on = [aws_eks_cluster.eks-cluster]

  name = aws_eks_cluster.eks-cluster[0].name
}