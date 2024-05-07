resource "helm_release" "aws_alb_controller" {
  name             = "aws-alb-controller"
  chart            = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts/"
  version          = var.aws_alb_controller_version
  namespace        = "aws-alb-controller"
  create_namespace = true

  values = [file("${var.values_file}")]
  
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_alb_controller_role.arn
  }
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-alb-controller-sa"
  }

  depends_on = [
    aws_iam_role_policy.aws_alb_controller_policy
  ]
}
