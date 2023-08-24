# Storage Account Customer Managed Key Example

Terraform configuration which creates a Storage account with a Customer Managed Key.

## Customer-Managed Key Example for Azure Storage Account

This Terraform configuration demonstrates how to create an Azure Storage Account with customer-managed keys using Azure Key Vault.

## Resources Created

- Azure Resource Group
- Azure Log Analytics Workspace
- Azure Storage Account
- Azure Key Vault
- Key Vault Access Policies
- Key Vault Key
- Storage Account Customer Managed Key

## Prerequisites

- Azure Subscription
- Terraform >= 1.3.0
- AzureRM Provider >= 3.39.0

## Inputs

| Name                 | Description                                                                                     | Type   | Default     |
|----------------------|-------------------------------------------------------------------------------------------------|--------|-------------|
| location             | The location to create the resources in.                                                       | string | "northeurope" |
| pname                | Project name to be used in the locals.                                                         | string | "pname"     |
| env                  | Environment name to be used in the locals.                                                     | string | "env"       |

## Outputs

| Name                  | Description                                                                                 |
|-----------------------|---------------------------------------------------------------------------------------------|
| resource_group_name   | The name of the resource group.                                                            |
| storage_account_name  | The name of the Storage account.                                                           |
| subscription_id       | The ID of the current subscription.                                                        |

## Usage

```hcl
module "customer_managed_key_example" {
  source      = "path/to/module"
  location    = "East US"
  pname       = "myproject"
  env         = "production"
}
```

## Note

- This example demonstrates how to create a customer-managed key for an Azure Storage Account using Azure Key Vault.
- Ensure that you have the required Azure credentials set up before using this example.
- This example uses the AzureRM provider, so ensure you have it configured with the required version.