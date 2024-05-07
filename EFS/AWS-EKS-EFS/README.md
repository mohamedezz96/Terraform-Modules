# Terraform Module: AWS EKS EFS

This Terraform module provisions an Amazon Elastic File System (EFS) and mounts it on Amazon Elastic Kubernetes Service (EKS) worker nodes. It simplifies the process of setting up shared storage for your EKS cluster.

## Prerequisites

Before using this module, ensure you have the following:

- AWS account
- Terraform installed (version >= 0.12.0)
- AWS CLI installed and configured
- EKS cluster created

## Usage

```hcl
module "eks_efs" {
  source         = "github.com/mohamedezz96/Terraform-Modules//EFS/AWS-EKS-EFS"
  eks_cluster_id = module.eks_cluster.id
  subnets        = module.eks_cluster.subnet_ids
}
```

## Inputs

