resource "helm_release" "cluster_autoscaler" {  
    name       = "cluster-autoscaler"
    repository = "https://kubernetes.github.io/autoscaler"
    chart      = "cluster-autoscaler"
    version    = var.cluster_autoscaler_version
    values           = ["${file(var.values_file)}"]

    namespace  = "cluster-autoscaler"
    create_namespace = true


    set {
        name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = aws_iam_role.eks_cluster_autoscaler_role.arn
    
    }
    
    set {
        name  = "autoDiscovery.clusterName"
        value = var.cluster_name
    }

    set {
        name  = "rbac.serviceAccount.name"
        value = "cluster-autoscaler"
    }

}