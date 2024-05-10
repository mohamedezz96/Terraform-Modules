data "tls_certificate" "eks_cluster_tls_cert" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_cluster_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cluster_tls_cert.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks_cluster_tls_cert.url
}