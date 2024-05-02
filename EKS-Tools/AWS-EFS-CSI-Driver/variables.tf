variable "aws_efs_csi_driver_version" {
  type        = string
  description = "The version of the AWS EFS CSI driver Helm chart to install."
}

variable "eks_issuer" {
  type        = string
  description = "The OIDC issuer URL for the EKS cluster."
}


variable "values_file" {
  type        = string
  description = "The path to the values.yaml file for the AWS EFS CSI driver Helm chart."
}

variable "cluster_name" {
  type = string
  default = "null"
  description = "The EKS Cluster Name"
}

variable "create_efs" {
  type = bool
  default = false
  description = "value to create AWS EFS With the driver or not"
}

variable "eks_vpc_id" {
  type = string
  default = "null"
  description = "The VPC ID where the EKS Cluster is Deployed"
}

variable "eks_worker_node_subnets" {
  type = list(string)
  default = ["null"]
  description = "The Subnets ID of EKS Worker Node"
}