variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
  
}

variable "cluster_autoscaler_version" {
  description = "Version of the Cluster Autoscaler helm chart to install"
  type = string
  default = "9.36.0"
  
}