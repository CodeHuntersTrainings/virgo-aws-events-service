# resource "helm_release" "kube-prometheus" {
#   count = var.kubernetes-enabled && var.monitoring-enabled ? 1 :0
#
#   depends_on          = [ aws_eks_cluster.eks-cluster ]
#   name                = "kube-prometheus"
#   namespace           = "monitoring"
#   repository          = "https://prometheus-community.github.io/helm-charts"
#   chart               = "kube-prometheus-stack"
#   create_namespace    = true
# }

# 1. Scale the cluster up manually in AWS Console (up to 10 instances)
# Endpoints:
#       kubectl port-forward svc/kube-prometheus-kube-prome-prometheus 9090:9090 --namespace monitoring
#       kubectl port-forward svc/kube-prometheus-grafana 3000:80 --namespace monitoring
#         Grafana: admin/prom-operator

