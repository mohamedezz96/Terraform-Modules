variable "cluster_endpoint" {
  type = string
}

variable "cluster_ca_cert" {
  type = string
}
variable "version" {
  type = string
  default = "1.7.2"
}
variable "eks_issuer" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "alb_sa_name" {
  type = string
}

variable "alb_policy_name" {
  type = string
}

variable "alb_role_name" {
  type = string
}

variable "values_file" {
  type = string
}
