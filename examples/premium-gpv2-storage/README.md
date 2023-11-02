# Premium GPv2 Storage Example

Terraform configuration which creates a Premium General-purpose v2 (GPv2) Storage account.

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
module "premium_gpv2_storage_example" {
  source      = "path/to/module"
  location    = "East US"
  pname       = "myproject"
  env         = "production"
}
```

## Note

- This example demonstrates how to create a Premium GPv2 Storage Azure Storage Account.
- Ensure that you have the required Azure credentials set up before using this example.
- This example uses the AzureRM provider, so ensure you have it configured with the required version.