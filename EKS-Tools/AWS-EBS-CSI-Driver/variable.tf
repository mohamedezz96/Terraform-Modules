variable "eks_issuer" {
  type        = string
  description = "The OIDC issuer URL for the EKS cluster."
  
}

variable "aws_ebs_csi_driver_version" {
  type        = string
  description = "The version of the AWS EBS CSI driver Helm chart to install."
  
}

variable "values_yaml" {
  type        = string
  description = "The path to the values.yaml file for the AWS EBS CSI driver Helm chart."
  
}

variable "aws_ebs_csi_driver_controller_sa_name" {
  type        = string
  description = "The name of the AWS EFS CSI driver service account."
  
}


variable "aws_ebs_csi_driver_node_sa_name" {
  type        = string
  description = "The name of the AWS EFS CSI driver node service account."
  
}
