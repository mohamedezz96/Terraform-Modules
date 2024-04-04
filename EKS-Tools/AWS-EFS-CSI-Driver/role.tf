data "aws_iam_openid_connect_provider" "eks_oidc" {
  url = var.eks_issuer
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks_issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:aws-efs-csi-driver:${var.aws_efs_controller_sa_name}", "system:serviceaccount:aws-efs-csi-driver:${var.aws_efs_node_sa_name}","sts.amazonaws.com"]
    }
    principals {
      identifiers = [data.aws_iam_openid_connect_provider.eks_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "aws_efs_csi_driver_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = var.aws_efs_csi_driver_role_name
}

resource "aws_iam_policy_attachment" "efs_csi_driver_policy_attachment" {
  name       = "AmazonEFSCSIDriverPolicyAttachment"
  roles      = [aws_iam_role.aws_efs_csi_driver_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}


