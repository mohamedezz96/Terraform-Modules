# AWS EBS CSI Driver Terraform Module

This Terraform module deploys an AWS EBS CSI (Container Storage Interface) Driver for use with Kubernetes clusters on Amazon EKS (Elastic Kubernetes Service). The CSI Driver enables Kubernetes pods to use Amazon EBS volumes as persistent storage.

## Usage

To use this module, include the following resource block in your Terraform configuration:

```hcl
module "ebs_csi_driver" {
  source = "github.com/mohamedezz96/Terraform-Modules//EKS-Tools/AWS-EBS-CSI-Driver"

  # Specify any required input variables here
}
```
## inputs

The following input variables are supported:

| Name                       | Description                                                             | Type   | Default | Required |
|----------------------------|-------------------------------------------------------------------------|--------|---------|----------|
| eks_issuer                 | The OIDC issuer URL for the EKS cluster.                                | string | N/A     | yes      |
| aws_ebs_csi_driver_version | The version of the AWS EBS CSI driver Helm chart to install.            | string | N/A     | yes      |
| values_file                | The path to the values.yaml file for the AWS EBS CSI driver Helm chart. | string | N/A     | yes      |


