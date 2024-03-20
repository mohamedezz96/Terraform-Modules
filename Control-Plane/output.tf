output "worker_node_sg_id" {
  value = aws_security_group.eks_worker_node.id
}

output "cluster_name" {
  value = aws_eks_cluster.eks-cluster.id
  description = "The Cluster Name"
}
/*
output "serviceaccount_role_name" {
  value = aws_iam_role.eks-SA-role.name
}
*/
