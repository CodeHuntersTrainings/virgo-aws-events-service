terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# To provision resources in AWS
provider "aws" {
  region = "eu-central-1"
}

# To install resources by Helm in EKS
provider "helm" {
  kubernetes {
    host                    = aws_eks_cluster.eks-cluster[0].endpoint
    cluster_ca_certificate  = base64decode(aws_eks_cluster.eks-cluster[0].certificate_authority.0.data)
    token                   = data.aws_eks_cluster_auth.eks-cluster-auth[0].token
  }
}

# To generate username and password for RDS
provider "random" {
}