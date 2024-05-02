resource "helm_release" "aws_efs_csi_driver" {
  name             = "aws-efs-csi-driver"
  repository       = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart            = "aws-efs-csi-driver"
  version          = var.aws_efs_csi_driver_version
  namespace        = "aws-efs-csi-driver"
  create_namespace = true
  wait             = false
  values           = ["${file(var.values_file)}"]

  set {
    name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_efs_csi_driver_iam_role.arn
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_efs_csi_driver_iam_role.arn
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "aws-efs-csi-driver-controller-sa"
  }

  set {
    name  = "node.serviceAccount.name"
    value = "aws-efs-csi-driver-node-sa"
  }
  depends_on = [ aws_efs_file_system.eks_efs ]

}
