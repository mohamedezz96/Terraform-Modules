# Terraform Module: EKS Cluster

This Terraform module creates an Amazon Elastic Kubernetes Service (EKS) cluster on AWS.

## Features

- Creates an EKS cluster with the specified configuration.
- Configures the necessary IAM roles and policies for the cluster.

## Usage

```hcl
module "eks-cluster" {
  source = "github.com/mohamedezz96/Terraform-Modules/EKS/EKS-Cluster"

  cluster_name = "Testing"
  cluster_version = "1.29"
  subnet_ids = module.eks-network.eks_vpc_subnet_ids
}
```
