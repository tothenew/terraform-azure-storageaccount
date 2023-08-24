provider "azurerm" {
  storage_use_azuread = true

  features {}
}

locals {
  env         = var.env
  name        = var.pname
  name_prefix = "${local.env}${local.name}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}

module "log_analytics" {
  source = "git::https://github.com/tothenew/terraform-azure-loganalytics.git"

  workspace_name      = "${local.name_prefix}-log"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "storage" {
  # source = "git::https://github.com/tothenew/terraform-azure-storageaccount.git"
  source = "../.."

  account_name               = "${local.name_prefix}st"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  shared_access_key_enabled  = true

  account_tier             = "Standard"
  account_replication_type = "GRS"

  identity = {
    type = "SystemAssigned"
  }

  blob_properties = {
    change_feed_enabled = false
    versioning_enabled  = false
    restore_policy_days = 0
  }

  share_properties = null
  queue_properties = null
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = module.storage.account_id
  key_vault_id       = module.vault.vault_id
  key_name           = azurerm_key_vault_key.vault_key.name
}

module "vault" {
  source = "git::https://github.com/tothenew/terraform-azure-keyvault.git"

  vault_name                 = "${local.name_prefix}-kv"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  purge_protection_enabled = true

  nacl_default_action = "Allow"
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = module.vault.vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.storage.identity_principal_id

  key_permissions    = ["Get", "Create", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = module.vault.vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get", "Set"]
}

resource "azurerm_key_vault_key" "vault_key" {
  name         = "example-key"
  key_vault_id = module.vault.vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.storage
  ]
}