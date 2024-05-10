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

## Inputs

| Name                        | Description                                        | Type          | Default   | Required |
|-----------------------------|----------------------------------------------------|---------------|-----------|:--------:|
| cluster_name                | The name of the EKS cluster.                       | `string`      |    N/A       |   yes    |
| cluster_version          | The Kubernetes version for the cluster.           | `string`      |        N/A   |   yes    |
| node_group_name             | The name of the node group.                        | `string`      |           |   yes    |
| node_instance_type          | The instance type for the nodes.                   | `string`      |           |   yes    |
| node_group_desired_capacity | The desired number of nodes in the node group.     | `number`      |           |   yes    |
| node_group_min_size         | The minimum number of nodes in the node group.     | `number`      |           |   yes    |
| node_group_max_size         | The maximum number of nodes in the node group.     | `number`      |           |   yes    |
| tags                        | A map of tags to apply to all resources created by the module. | `map(string)` | `{}` |   no     |
