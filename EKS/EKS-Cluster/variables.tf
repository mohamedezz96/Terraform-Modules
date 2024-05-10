variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
}

variable "cluster_version" {
  description = "Version of the EKS cluster"
  type = string 
}

variable "subnet_ids" {
  description = "List of subnet IDs Public & Private"
  type = list(string)  
}