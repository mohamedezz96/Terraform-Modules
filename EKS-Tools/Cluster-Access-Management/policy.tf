resource "aws_iam_policy" "eks_admin_policy" {
  name        = "eks-admin-policy"
  description = "IAM policy for Administrators EKS Cluster access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["eks:*"]
        Resource = "*"
      },
      {
        Effect    = "Allow"
        Action    = "iam:PassRole"
        Resource  = "*"
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "eks.amazonaws.com"
          }
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "eks_admin_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.aws_account_id]
    }
  }
}

resource "aws_iam_role" "eks_admin_role" {
  name               = "eks-admin-role"
  assume_role_policy = data.aws_iam_policy_document.eks_admin_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_admin_policy_attachment" {
  role       = aws_iam_role.eks_admin_role.name
  policy_arn = aws_iam_policy.eks_admin_policy.arn
}

resource "null_resource" "configmap-edit" {

  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      rolearn="${aws_iam_role.eks_admin_role.arn}"  
      file="./maproles.txt"  
      sed -i "/username: eks-admin/{x;p;x;s/rolearn:.*/rolearn: $rolearn/}" "$file"
    EOT
  }
}


