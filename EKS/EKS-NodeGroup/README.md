# Terraform Module: EKS Node Group

This Terraform module creates a node group for an Amazon Elastic Kubernetes Service (EKS) cluster on AWS.

## Features

- Creates a node group with the specified configuration and attaches it to an existing EKS cluster.
- Configures the necessary IAM roles and policies for the node group.

## Usage

```hcl
module "eks-node-group" {
  source = "github.com/mohamedezz96/Terraform-Modules/EKS/EKS-NodeGroup"

  cluster_name = module.eks-cluster.cluster_name
  node_group_name = "Group-A"
  eks_vpc_private_subnet_ids = module.eks-network.eks_vpc_private_subnet_ids

  node_group_ami_type = "BOTTLEROCKET_x86_64"
  node_group_instance_type = ["t3.medium"]
  node_group_capacity_type = "ON_DEMAND"

  node_group_desired_size = 3
  node_group_max_size = 5
  node_group_min_size = 3
  node_group_max_unavailable = 1
}
```
## Inputs

| Name                        | Description                                        | Type          | Default   | Required |
|-----------------------------|----------------------------------------------------|---------------|-----------|:--------:|
| cluster_name                | The name of the EKS cluster.                       | `string`      |    N/A       |   yes    |
| node_group_name             | The name of the node group.                        | `string`      |    N/A     |   yes    |
| eks_vpc_private_subnet_ids  | The EKS VPC private subnets IDs.                   | `list`        |    N/A    |  yes     |
| node_group_ami_type         | The Type of Node Group nodes AMI                   | `string`      | `BOTTLEROCKET_x86_64`|   No    |
| node_group_instance_type    | The instance type for the Node Group nodes         | `list`        | `t3.medium`          |   No    |
| node_group_desired_capacity | The desired number of nodes in the node group.     | `number`      |   `2`        |   No    |
| node_group_min_size         | The minimum number of nodes in the node group.     | `number`      |   `2`        |   No    |
| node_group_max_size         | The maximum number of nodes in the node group.     | `number`      |    `3`       |   No    |
| node_group_max_unavailable  | The maximum unavailable number of nodes in the node group. | `number` | `1` |   No     |



