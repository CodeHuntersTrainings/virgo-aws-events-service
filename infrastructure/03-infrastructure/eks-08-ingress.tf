resource "helm_release" "ingress" {
  depends_on       = [
    aws_eks_cluster.eks-cluster,
    aws_eks_node_group.node-ec2
  ]

  count = var.kubernetes-enabled ? 1 :0

  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
}
