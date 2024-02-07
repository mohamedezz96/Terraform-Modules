variable "cluster_name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "desired_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "min_size" {
  type = string
}



#Valid Values: AL2_x86_64 | AL2_x86_64_GPU | AL2_ARM_64 | CUSTOM | BOTTLEROCKET_ARM_64 | BOTTLEROCKET_x86_64 | BOTTLEROCKET_ARM_64_NVIDIA | BOTTLEROCKET_x86_64_NVIDIA | WINDOWS_CORE_2019_x86_64 | WINDOWS_FULL_2019_x86_64 | WINDOWS_CORE_2022_x86_64 | WINDOWS_FULL_2022_x86_64
variable "ami_type" {
  type    = string
  default = "BOTTLEROCKET_x86_64"
}


variable "disk_size" {
  type    = number
  default = 20
}
variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "cluster_version" {
  type = string
}



variable "worker_node_sg" {
  type = string
}