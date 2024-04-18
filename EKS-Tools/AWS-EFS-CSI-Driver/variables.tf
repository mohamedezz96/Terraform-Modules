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
