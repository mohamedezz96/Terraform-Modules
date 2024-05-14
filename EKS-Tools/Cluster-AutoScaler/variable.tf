variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
  
}

variable "cluster_autoscaler_version" {
  description = "Version of the Cluster Autoscaler helm chart to install"
  type = string
  default = "9.36.0"
  
}

variable "eks_issuer" {
  type        = string
  description = "The OIDC issuer URL for the EKS cluster."
}

variable "values_file" {
  type        = string
  description = "The path to the values.yaml file for the AWS EFS CSI driver Helm chart."
}