data "aws_iam_openid_connect_provider" "eks_cluster_oidc" {
  url = var.eks_issuer
}


