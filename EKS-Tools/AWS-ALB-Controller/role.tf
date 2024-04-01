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
      values   = ["system:serviceaccount:aws-alb-controller:${var.alb_sa_name}"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.eks_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "default" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = var.alb_role_name
}

resource "aws_iam_role_policy" "default" {
  name   = var.alb_policy_name
  role   = aws_iam_role.default.id
  policy = file("${path.module}/policy.json")
}
