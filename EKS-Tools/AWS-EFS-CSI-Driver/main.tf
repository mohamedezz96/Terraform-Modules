data "aws_efs_file_system" "efs" {
  tags = {
    Name = var.efs-name
  }
}

resource "helm_release" "efs_provisioner" {
  name = "efs-provisioner"

  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  version    = "2.5.3"

  namespace        = "efs-provisioner"
  create_namespace = true

  wait = false

  values = [file("${var.values_file}")]

  set {
    name  = "storageClasses[0].parameters.fileSystemId"
    value = data.aws_efs_file_system.efs.file_system_id
  }

  set {
    name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.default.arn
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.default.arn
  }

  set {
    name  = "controller.serviceAccount.name"
    value = var.efs_controller_sa_name
  }

  set {
    name  = "node.serviceAccount.name"
    value = var.efs_node_sa_name
  }

  depends_on = [
    aws_iam_role_policy.default
  ]
}

