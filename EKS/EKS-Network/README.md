# Terraform Modules: EKS Network

This Terraform module creates a network infrastructure for an Amazon Elastic Kubernetes Service (EKS) cluster on AWS.

## Features

- Creates a Virtual Private Cloud (VPC) with public and private subnets.
- Configures internet and NAT gateways for internet access and outbound traffic.
- Sets up route tables for routing traffic within the VPC and to the internet.

## Usage

```hcl
module "eks-network" {
  source          = "github.com/mohamedezz96/Terraform-Modules/EKS/EKS-Network"

  vpc_cidr_block  = "10.0.0.0/16"

  private_subnets_cidr_block = {
    us-east-1a = "10.0.0.0/19"
    us-east-1b = "10.0.32.0/19"
    us-east-1c = "10.0.64.0/19"
  }

  public_subnets_cidr_block = {
    us-east-1a = "10.0.96.0/19"
    us-east-1b = "10.0.128.0/19"
    us-east-1c = "10.0.160.0/19"
  }
}
```
## Inputs

| Name                         | Description                                                                        | Type     | Default                                                    | Required |
|------------------------------|------------------------------------------------------------------------------------|----------|------------------------------------------------------------|----------|
| `vpc_cidr_block`             | CIDR BlOCK for EKS CLuster VPC                                                     | `string` | `"10.0.0.0/16"`                                            | No       |
| `private_subnets_cidr_block` | CIDR BLOCK for EKS private subnets and the AZ in which this subnet will be created | `map`    | `us-east-1a = "10.0.0.0/19"   us-east-1b = "10.0.32.0/19"`  | No       |
| `public_subnets_cidr_block`  | CIDR BLOCK for EKS public subnets and the AZ in which this subnet will be created  | `map`    | `us-east-1a = "10.0.64.0/19"  us-east-1b = "10.0.96.0/19"` | No       |

  ### Notes
  x
  t
  s

