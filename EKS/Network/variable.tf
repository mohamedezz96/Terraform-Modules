variable "vpc_cidr_block" {
  description = "value of the VPC CIDR block"
  type = string
  default = "10.0.0.0/16"
}


variable "private_subnets_cidr_block" {
  description = "Map of AZ and private subnets cidr block"
  type = map(any)
  default = {
    us-east-1a = "10.0.0.0/19"
    us-east-1b = "10.0.32.0/19"
  }
}

variable "public_subnets_cidr_block" {
  description = "Map of AZ and public subnets cidr block"
  type = map(any)
  default = {
    us-east-1a = "10.0.64.0/19"
    us-east-1b = "10.0.96.0/19"
  }
  
}