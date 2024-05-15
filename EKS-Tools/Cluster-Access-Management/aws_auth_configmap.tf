resource "kubernetes_config_map" "aws-auth" {
  data = {
    "mapRoles" = "${file("${path.module}/maproles.txt")}"
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  depends_on = [ null_resource.configmap-edit ]
}
