# Standard Blob Storage Example

Terraform configuration which creates a Standard Blob Storage account.

This is considered a [legacy storage account type](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview#legacy-storage-account-types). Microsoft recommends using [standard general-purpose v2 (GPv2) accounts](../standard-gpv2-storage/) instead when possible.

## Resources Created

- Azure Resource Group
- Azure Log Analytics Workspace
- Azure Storage Account

## Prerequisites

- Azure Subscription
- Terraform >= 1.3.0
- AzureRM Provider >= 3.39.0

## Inputs

| Name                 | Description                                                                                        | Type   | Default       |
|----------------------|----------------------------------------------------------------------------------------------------|--------|---------------|
| location             | The location to create the resources in.                                                          | string | "northeurope" |
| pname                | Project name to be used in the locals.                                                            | string | "pname"       |
| env                  | Environment name to be used in the locals.                                                        | string | "env"         |

## Outputs

| Name                  | Description                                                                                      |
|-----------------------|--------------------------------------------------------------------------------------------------|
| resource_group_name   | The name of the resource group.                                                                  |
| storage_account_name  | The name of the Storage account.                                                                 |
| subscription_id       | The ID of the current subscription.                                                              |

## Usage

```hcl
module "standard_blob_storage_example" {
  source      = "path/to/module"
  location    = "East US"
  pname       = "myproject"
  env         = "production"
}
```

## Note

- This example demonstrates how to create a Standard Blob Storage Azure Storage Account.
- Ensure that you have the required Azure credentials set up before using this example.
- This example uses the AzureRM provider, so ensure you have it configured with the required version.