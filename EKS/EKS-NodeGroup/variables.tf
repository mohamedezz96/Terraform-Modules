variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type = string 
}

variable "eks_vpc_private_subnet_ids" {
  description = "List of private subnet IDs for the EKS node group"
  type = list(string)  
}