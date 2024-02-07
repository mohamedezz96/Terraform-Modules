data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_clutser_role" {
  name               = "eks-cluster-controlplane-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_clutser_role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_clutser_role.name
}


# Enabling IAM Roles for ServiceAccounts

data "tls_certificate" "eks-cluster-tls" {
  url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-cluster-oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks-cluster-tls.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.eks-cluster-tls.url
}

data "aws_iam_policy_document" "eks-cluster-SA-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks-cluster-oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks-cluster-oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks-SA-role" {
  assume_role_policy = data.aws_iam_policy_document.eks-cluster-SA-policy.json
  name               = "eks-cluster-SA-role"
}