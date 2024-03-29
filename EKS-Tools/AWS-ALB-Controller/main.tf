resource "helm_release" "aws_alb_controller" {
  name = "aws-alb-controller"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts/"
  version    = "1.7.2"
  namespace        = "aws-alb-controller"
  create_namespace = true

  values = [file("${var.values_file}")]
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.default.arn
  }
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = var.alb_sa_name
  }

  depends_on = [
    aws_iam_role_policy.default
  ]
}
