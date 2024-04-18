# AWS EFS CSI Driver Terraform Module

This Terraform module deploys an AWS EFS CSI (Container Storage Interface) Driver for use with Kubernetes clusters on Amazon EKS (Elastic Kubernetes Service). The CSI Driver enables Kubernetes pods to use Amazon EFS (Elastic File System) volumes as persistent storage.

## Usage

```hcl
module "efs_csi_driver" {
  source = "github.com/mohamedezz96/Terraform-Modules//EKS-Tools/AWS-EFS-CSI-Driver"

  # Specify any required input variables here
}
```
## inputs

The following input variables are supported:

| Name                         | Description                                                             | Type     | Default | Required |
|------------------------------|-------------------------------------------------------------------------|----------|---------|----------|
| `eks_issuer`                 | The OIDC issuer URL for the EKS cluster.                                | `string` | `N/A`   | yes      |
| `aws_efs_csi_driver_version` | The version of the AWS EFS CSI driver Helm chart to install.            | `string` | `N/A`   | yes      |
| `values_file`                | The path to the values.yaml file for the AWS EFS CSI driver Helm chart. | `string` | `N/A`   | yes      |




