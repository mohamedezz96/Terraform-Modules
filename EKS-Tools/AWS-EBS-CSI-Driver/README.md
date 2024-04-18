# AWS EBS CSI Driver Terraform Module

This Terraform module deploys an AWS EBS CSI (Container Storage Interface) Driver for use with Kubernetes clusters on Amazon EKS (Elastic Kubernetes Service). The CSI Driver enables Kubernetes pods to use Amazon EBS volumes as persistent storage.

## Usage

To use this module, include the following resource block in your Terraform configuration:

```hcl
module "ebs_csi_driver" {
  source = "github.com/mohamedezz96/Terraform-Modules//EKS-Tools/AWS-EBS-CSI-Driver"

  # Specify any required input variables here
}

## Inputs

The following input variables are supported:

|Name|Description|Type|Default|Required|
|------|-------------|------|---------|:--------:|
|`aws_ebs_csi_driver_version`|The version of the AWS EBS CSI driver Helm chart to install.|`string`|`N/A`|Yes|
|`eks_issuer`|The OIDC issuer URL for the EKS cluster.|`string`|`N/A`|Yes|
|`values_file`|The path to the values.yaml file for the AWS EBS CSI driver Helm chart.|`string`|`N/A`|Yes|

| Header 1    | Header 2    | Header 3    |
|-------------|-------------|-------------|
| Row 1, Col 1 | Row 1, Col 2 | Row 1, Col 3 |
| Row 2, Col 1 | Row 2, Col 2 | Row 2, Col 3 |


Replace `example_variable` with the name of your input variable, and provide a brief description of its purpose. Similarly, replace `Description of the example variable.` with a more detailed explanation of what the variable does.

For the `Type` column, specify the data type of the variable, such as `string`, `number`, `bool`, or `list`.

In the `Default` column, provide the default value of the variable, if any. If the variable is required and has no default value, you can indicate it as `"N/A"` or leave it empty.

In the `Required` column, specify whether the variable is required (`Yes`) or optional (`No`). If a variable is required, users must provide a value for it in their Terraform configuration.

Include as many input variables as necessary for your module, following the same format.
