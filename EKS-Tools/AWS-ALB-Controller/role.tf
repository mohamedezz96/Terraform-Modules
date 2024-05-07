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
      values   = ["system:serviceaccount:aws-alb-controller:aws-alb-controller-sa"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.eks_oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "aws_alb_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "aws-alb-controller-role"
}

resource "aws_iam_role_policy" "aws_alb_controller_policy" {
  name   = "aws-alb-controller-policy"
  role   = aws_iam_role.aws_alb_controller_role.id
  policy = file("${path.module}/policy.json")
}
