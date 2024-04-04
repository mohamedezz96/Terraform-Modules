variable "aws_efs_csi_driver_version" {
  type = string
}

variable "eks_issuer" {
  type = string
}


variable "aws_efs_controller_sa_name" {
  type = string
}

variable "aws_efs_node_sa_name" {
  type = string
}

variable "aws_efs_csi_driver_role_name" {
  type = string
}

variable "aws_efs_csi_driver_policy_name" {
  type = string
}

variable "values_file" {
  type = string
}
