variable "cluster_name" {
  description = "The Required Cluster Name"
  type = string
}

variable "cluster_version" {
  description = "The Required Kubernetes Version"
  type = string
}

variable "subnet_ids" {
  description = "Subnets id where our control plane will be deployed"
  type = list(any)
}


variable "auth_mode" {
  default = "API_AND_CONFIG_MAP"
  type    = string
}

variable "vpc_id" {
  type = string
}
variable "cluster_log_retention_in_days" {
  type    = number
  default = 7
}



variable "cluster_ipv4_cidr" {
  type    = string
  default = "10.10.0.0/16"
}
