resource "helm_release" "eks-aws-auth" {
  name       = "eks-aws-auth"
  repository = "${path.module}/eks-aws-auth-chart"
  chart      = "eks-aws-auth-chart"
  namespace  = "kube-system"
  version    = "0.1.0"
  values = ["${file("${path.module}/eks-aws-auth-chart/values.yaml")}"]

  set {
    name = "awsAuthConfig.mapRoles[0].rolearn"
    value = "arn:aws:iam::${var.aws_account_id}:role/eks-node-group-role"
  }


  

  
}