variable "eks_cluster_vpc_id" {
  type        = string
  description = "EKS Cluster VPC ID"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}

variable "eks_workernode_subnets_id" {
  type        = list(string)
  description = "The Subnets ID where the EKS WorkerNode is Deployed"
}