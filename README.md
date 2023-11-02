# azurerm-storage

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

# Azure Storage Account Terraform Module

This Terraform module creates an Azure Storage Account with customizable settings.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [azurerm](#requirement\_terraform) | >= 3.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_advanced_threat_protection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/advanced_threat_protection) | resource |

## Resources Created

- Azure Storage Account
- Advanced Threat Protection (Microsoft Defender for Storage) Configuration
- Monitor Diagnostic Setting for Storage Account

## Prerequisites

Before using this Terraform module, ensure that you have the following prerequisites:

1. **Azure Account**: You need an active Azure account to deploy the resources.
2. **Terraform**: Install Terraform on your local machine. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
3. **Azure CLI**: Install the Azure CLI on your local machine. You can download it from the [Azure CLI website](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

- Terraform version >= 1.3.0 is required.
- Azure provider version >= 3.16.0 is required.

## Configure Azure Provider

To configure the Azure provider, you need to set up the necessary Azure credentials. If you already have the Azure CLI installed and authenticated with Azure, Terraform will use the same credentials.

If you haven't authenticated with Azure, you can do so by running:

```bash
az login
```


## Clone the Repository

First, clone this repository to your local machine using the following command:

```bash
git clone <repository_url>
cd <repository_name>
```

## Initialize Terraform

Once you have cloned the repository, navigate to the module directory and initialize Terraform:

```bash
cd path/to/module_directory
terraform init
```

This will download the necessary plugins required for Terraform to work with Azure.

## Apply the Terraform Configuration

After configuring the input variables, you can apply the Terraform configuration to create the Azure Container Group:

```bash
terraform apply
```

Terraform will show you the changes that will be applied to the infrastructure. Type `yes` to confirm and apply the changes.

## Clean Up

To clean up the resources created by Terraform, you can use the `destroy` command:

```bash
terraform destroy
```

Terraform will show you the resources that will be destroyed. Type `yes` to confirm and destroy the resources.


## Inputs

| Name                                 | Description                                                                                                                                                 | Type      | Default                                       |
|--------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|-----------------------------------------------|
| resource_group_name                  | The name of the resource group to create the resources in.                                                                                                 | string    |                                               |
| location                             | The location to create the resources in.                                                                                                                   | string    |                                               |
| account_name                         | The name of this Storage account.                                                                                                                           | string    |                                               |
| account_kind                         | The Kind of this Storage account.                                                                                                                           | string    | "StorageV2"                                   |

## Outputs

| Name                           | Description                                                                           |
|--------------------------------|---------------------------------------------------------------------------------------|
| account_id                     | The ID of this Storage account.                                                       |
| account_name                   | The name of this Storage account.                                                     |
| identity_principal_id          | The principal ID of the system-assigned identity of this Storage Account.             |
| account_tier                   | The Tier of this Storage Account.                                                     |
| account_kind                   | The Kind of this Storage 

## Usage

```hcl
module "storage_account" {
  source               = "path/to/module"
  resource_group_name  = "my-rg"
  location             = "East US"
  account_name         = "mystorageaccount"
}
```

## List of variables


| Variable Name                                 | Description                                                    | Type          | Required | Default Value        |
|-----------------------------------------------|----------------------------------------------------------------|---------------|----------|----------------------|
| `resource_group_name`                         | The name of the resource group to create the resources in.   | `string`      | Yes      |                      |
| `location`                                    | The location to create the resources in.                     | `string`      | Yes      |                      |
| `account_name`                                | The name of this Storage account.                            | `string`      | Yes      |                      |
| `account_kind`                                | The Kind of this Storage account.                            | `string`      | No       | `"StorageV2"`        |
| `account_tier`                                | The Tier of this Storage account.                            | `string`      | No       | `"Standard"`         |
| `account_replication_type`                    | The type of replication to use for this Storage account.    | `string`      | No       | `"RAGRS"`            |
| `access_tier`                                 | The access tier to use for this Storage account.             | `string`      | No       | `"Hot"`              |
| `shared_access_key_enabled`                   | Is authorization with access key enabled for this Storage account? | `bool` | No       | `false`              |
| `is_hns_enabled`                              | Is Data Lake Storage Gen2 hierarchical namespace enabled for this Storage account? | `bool` | No | `false` |
| `queue_encryption_key_type`                   | The type of encryption to use for Queue Storage.             | `string`      | No       | `"Service"`          |
| `table_encryption_key_type`                   | The type of encryption to use for Table Storage.             | `string`      | No       | `"Service"`          |
| `allow_blob_public_access`                    | Allow public access to Blob Storage?                        | `bool`        | No       | `false`              |
| `cross_tenant_replication_enabled`            | Allow cross-tenant replication?                             | `bool`        | No       | `false`              |
| `blob_properties`                             | Properties of Blob Storage.                                  | `object`      | No       | `{}`                 |
| `share_properties`                            | Properties of Share Storage.                                 | `object`      | No       | `{}`                 |
| `queue_properties`                            | Properties of Queue Storage.                                 | `object`      | No       | `{}`                 |
| `identity`                                    | Identity to configure for this Storage account.              | `object`      | No       | `null`               |
| `network_rules_virtual_network_subnet_ids`    | Allowed subnet resources ids using service endpoints.       | `list(string)` | No       | `[]`                 |
| `custom_domain`                               | Custom (sub) domain name of the Storage Account.             | `object`      | No       | `null`               |
| `network_rules_default_action`                | Default network access rule for the storage account.        | `string`      | No       | `"Deny"`             |
| `network_rules_bypass`                        | Specifies whether traffic is bypassed for certain services. | `list(string)` | No       | `["AzureServices"]`  |
| `network_rules_ip_rules`                      | Public IPs or IP ranges in CIDR format to access the Storage account. | `list(string)` | No | `[]`           |
| `advanced_threat_protection_enabled`          | Is advanced threat protection (Microsoft Defender for Storage) enabled? | `bool` | No   | `true`               |
| `log_analytics_workspace_id`                  | ID of the Log Analytics workspace to send diagnostics to.   | `string`      | No       |                      |
| `log_analytics_destination_type`              | Type of log analytics destination to use for Log Analytics Workspace. | `string` | No | `null`           |
| `diagnostic_setting_enabled_log_categories`   | List of log categories to be enabled for diagnostic setting. | `list(string)` | No    | `["StorageRead", "StorageWrite", "StorageDelete"]` |
| `name`                                        | String value to describe prefix of all the resources.       | `string`      | No       | `""`                 |
| `default_tags`                                | Map to add common tags to all the resources.                | `map(string)` | No       | See below            |
| `common_tags`                                 | Map to add common tags to all the resources.                | `map(string)` | No       | `{}`                 |
| `enable_https_traffic_only`                   | Value indicating if only HTTPS traffic is allowed.          | `bool`        | No       | `true`               |
| `min_tls_version`                             | Minimum TLS version.                                        | `string`      | No       | `"TLS1_2"`            |
| `diagnostic_setting_name`                     | Name of the diagnostic setting.                             | `string`      | No       | `"audit-logs"`       |

Default value for `default_tags`:
```hcl
{
  "Scope": "Storage-Account",
  "CreatedBy": "Terraform"
}
```

Please note that the variables in the "Required" column that are marked "No" can be left empty if you don't want to provide a value for them.

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.