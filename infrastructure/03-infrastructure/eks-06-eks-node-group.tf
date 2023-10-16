# Terraform module: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
# Example: https://dev.to/aws-builders/creating-an-eks-cluster-and-node-group-with-terraform-1lf6

resource "aws_eks_node_group" "node-ec2" {
  count = var.kubernetes-enabled ? 1 :0

  cluster_name    = aws_eks_cluster.eks-cluster[0].name
  node_group_name = "ch-t2-micro-node-group"
  node_role_arn   = aws_iam_role.eks-node-group-role[0].arn
  subnet_ids      = aws_subnet.private-subnets.*.id

  scaling_config {
    desired_size = 4
    max_size     = 15
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  instance_types = [ ( var.monitoring-enabled || var.database-enabled) ? "t2.medium" : "t2.micro" ]
  capacity_type  = "ON_DEMAND"
  disk_size      = 15

  depends_on = [
    aws_iam_role_policy_attachment.cluster-policy-to-eks-cluster-role,
    aws_iam_role_policy_attachment.node-policy-to-eks-node-role,
    aws_iam_role_policy_attachment.cni-policy-to-eks-node-group-role,
    aws_iam_role_policy_attachment.ecr-read-only-to-eks-node-group-role
  ]
}

# Command: aws eks update-kubeconfig --region eu-central-1 --name codehunters-eks-cluster