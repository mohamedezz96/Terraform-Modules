resource "helm_release" "aws_ebs_csi_driver" {
  name             = "aws-ebs-csi-driver"
  repository       = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver/"
  chart            = "aws-ebs-csi-driver"
  version          = var.aws_ebs_csi_driver_version
  namespace        = "aws-ebs-csi-driver"
  create_namespace = true
  wait             = false
  values           = ["${file(var.values_yaml)}"]

  set {
    name  = "controller.serviceAccount.name"
    value = "aws-ebs-csi-driver-controller-sa"
  }

  set {
    name  = "node.serviceAccount.name"
    value = "aws-ebs-csi-driver-node-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = data.aws_iam_role.aws_ebs_csi_driver_role.arn
  }

  set {
    name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = data.aws_iam_role.aws_ebs_csi_driver_role.arn
  }
}
