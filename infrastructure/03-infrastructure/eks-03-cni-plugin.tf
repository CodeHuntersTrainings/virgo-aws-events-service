# EKS needs to have ability to change IP addresses
# To modify the IP address configuration on your EKS worker nodes
# ENI = Elastic Network Interface
resource "aws_iam_role_policy_attachment" "cni-policy-to-eks-node-group-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role[0].name
}