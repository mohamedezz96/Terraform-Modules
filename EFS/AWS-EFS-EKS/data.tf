data "aws_vpc" "eks_cluster_vpc" {
  id = var.eks_cluster_vpc_id
}