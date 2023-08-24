resource "azurerm_advanced_threat_protection" "threat_protection" {
  target_resource_id = azurerm_storage_account.sa.id
  enabled            = var.advanced_threat_protection_enabled
}