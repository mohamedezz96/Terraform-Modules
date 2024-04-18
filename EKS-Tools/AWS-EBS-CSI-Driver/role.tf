data "aws_iam_openid_connect_provider" "eks_oidc" {
  url = var.eks_issuer
}

resource "aws_iam_policy" "aws_ebs_csi_driver_policy" {
  name        = "aws-ebs-csi-driver-policy"
  description = "EBS CSI Driver Policy with Encrypted Volumes Support"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = file("./policy.json")
}

data "aws_iam_policy_document" "aws_ebs_csi_driver_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.eks_oidc.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks_issuer, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks_issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:aws-ebs-csi-driver:aws-ebs-csi-driver-controller-sa", "system:serviceaccount:aws-ebs-csi-driver:aws-ebs-csi-driver-node-sa"]
    }
  }
}

resource "aws_iam_role" "aws_ebs_csi_driver_role" {
  name                = "aws-ebs-csi-driver-role"
  assume_role_policy  = data.aws_iam_policy_document.aws_ebs_csi_driver_policy.json
  managed_policy_arns = aws_iam_policy.aws_ebs_csi_driver_policy.arn
}
