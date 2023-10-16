resource "helm_release" "secrets-store-csi-driver" {
  depends_on       = [
    aws_eks_cluster.eks-cluster,
    aws_eks_node_group.node-ec2
  ]

  count = var.kubernetes-enabled && var.database-enabled ? 1 : 0

  name             = "secrets-store-csi-driver"
  repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts/"
  chart            = "secrets-store-csi-driver"
  namespace        = "kube-system"
}

resource "helm_release" "ascp" {
  depends_on       = [ helm_release.secrets-store-csi-driver ]

  count = var.kubernetes-enabled && var.database-enabled ? 1 : 0

  name             = "csi-secrets-store-provider-aws"
  repository       = "https://aws.github.io/secrets-store-csi-driver-provider-aws/charts/"
  chart            = "csi-secrets-store-provider-aws"
  namespace        = "kube-system"
}
