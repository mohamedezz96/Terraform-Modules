# Terraform Modules: EKS Network

This Terraform module creates a network infrastructure for an Amazon Elastic Kubernetes Service (EKS) cluster on AWS.

## Features

- Creates a Virtual Private Cloud (VPC) with public and private subnets.
- Configures internet and NAT gateways for internet access and outbound traffic.
- Sets up route tables for routing traffic within the VPC and to the internet.

## Usage

```hcl
module "eks_network" {
  source              = "github.com/mohamedezz96/Terraform-Modules//EKS/EKS-Network"
  region              = "us-west-2"
  vpc_cidr            = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  tags = {
    Name = "eks-network"
    Environment = "production"
  }
}
```
