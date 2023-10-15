# Source: https://registry.terraform.io/modules/tedilabs/account/aws/latest/submodules/iam-oidc-identity-provider
# Source: https://marcincuber.medium.com/amazon-eks-with-oidc-provider-iam-roles-for-kubernetes-services-accounts-59015d15cb0c

module "account_iam-oidc-identity-provider" {
  count = var.kubernetes-enabled ? 1 :0

  source  = "tedilabs/account/aws//modules/iam-oidc-identity-provider"
  version = "0.27.0"

  url = aws_eks_cluster.eks-cluster[0].identity.0.oidc.0.issuer
}

resource "aws_iam_role" "codehunters-events-service-role" {
  count = var.kubernetes-enabled ? 1 :0

  name = "CodeHuntersEventsServiceEKSRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = module.account_iam-oidc-identity-provider[0].arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${module.account_iam-oidc-identity-provider[0].url}:sub" = "system:serviceaccount:czirjak:service-account-events-service"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "service-account-s3-policy-to-eks-cluster-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.codehunters-events-service-role[0].name
}

resource "aws_iam_role_policy_attachment" "service-account-rds-policy-to-eks-cluster-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = aws_iam_role.codehunters-events-service-role[0].name
}

resource "aws_iam_role_policy_attachment" "service-account-sqs-policy-to-eks-cluster-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  role       = aws_iam_role.codehunters-events-service-role[0].name
}

resource "aws_iam_role_policy_attachment" "service-account-secret-manager-policy-to-eks-cluster-role" {
  count = var.kubernetes-enabled ? 1 :0

  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role       = aws_iam_role.codehunters-events-service-role[0].name
}
