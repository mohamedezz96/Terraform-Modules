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

variable "node_group_ami_type" {
  description = "AMI type for the EKS node group"
  type = string
  default = "BOTTLEROCKET_x86_64"
}

variable "node_group_instance_type" {
  description = "Instance type for the EKS node group"
  type = list(string)
  default = ["t3.small"]
}

variable "node_group_capacity_type" {
  description = "Capacity type for the EKS node group"
  type = string
  default = "ON_DEMAND"
}

variable "node_group_desired_size" {
  description = "Desired size for the EKS node group"
  type = number
  default = 2
}

variable "node_group_max_size" {
  description = "Max size for the EKS node group"
  type = number
  default = 3
}


variable "node_group_min_size" {
  description = "Min size for the EKS node group"
  type = number
  default = 2
}

variable "node_group_max_unavailable" {
  description = "Max unavailable for the EKS node group"
  type = number
  default = 1
}