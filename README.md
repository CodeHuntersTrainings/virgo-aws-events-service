# Kubernetes Commands
aws eks update-kubeconfig --region eu-central-1 --name codehunters-eks-cluster

# Monitoring Commands
kubectl port-forward svc/kube-prometheus-kube-prome-prometheus 9090:9090 --namespace monitoring
kubectl port-forward svc/kube-prometheus-grafana 3000:80 --namespace monitoring

## Grafana Login
admin / prom-operator or admin / admin

