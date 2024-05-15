# Terraform Module: EKS Addons

This Terraform module simplifies the process of deploying common Kubernetes addons on an Amazon EKS cluster.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Inputs](#inputs)

## Features

- Easy deployment of common Kubernetes addons like coreDNS, AWS CNI, Kube-Proxy, and more.
- Customizable configuration options to suit your needs.
- Simplified Terraform code for managing EKS addons.

## Prerequisites

Before using this module, ensure you have the following prerequisites:

- An existing Amazon EKS cluster.
- Terraform installed on your local machine.
- AWS credentials configured with the necessary permissions to manage EKS resources.

## Usage

```hcl
module "eks_addons" {
  source  = "mohamedezz96/EKS-Addons/aws"
  cluster_name = module.eks-cluster.cluster_name
}
```

## Inputs

| Name          | Description                               | Type   | Default | Required |
|---------------|-------------------------------------------|--------|---------|----------|
| cluster_name  | The name of the EKS cluster to apply the addons to. | string |   N/A      | yes      |


