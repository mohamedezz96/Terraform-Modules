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
  eks_cluster_vpc_id          = xxxxx
  eks_workernode_subnets_id   = [xxxxx,xxxxx,xxxx]
  eks_cluster_name            = xxxxxx
}
```

## Inputs
| Name                        | Description                                         | Type           | Default | Required |
|-----------------------------|-----------------------------------------------------|----------------|---------|----------|
| `eks_cluster_vpc_id`        | EKS Cluster VPC ID                                  | `string`       | `N/A`   | yes      |
| `eks_cluster_name`          | EKS Cluster Name                                    | `string`       | `N/A`   | yes      |
| `eks_workernode_subnets_id` | The Subnets ID where the EKS WorkerNode is Deployed | `list(string)` | `N/A`   | yes      |
