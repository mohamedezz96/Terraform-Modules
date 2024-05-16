variable "aws_account_id" {
  type = string
  description = "AWS account ID"
}

variable "values_file" {
  type        = string
  description = "The path to the values.yaml file for the AWS EFS CSI driver Helm chart."
}