output "resource_group_name" {
  description = "The name of this resource group."
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "The name of this Storage account."
  value       = module.storage.account_name
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

output "subscription_id" {
  description = "The ID of the current subscription."
  value       = data.azurerm_subscription.current.subscription_id
}