resource "azurerm_monitor_diagnostic_setting" "monitor" {
    for_each = toset(["blob", "queue", "table", "file"])
  
    name                           = var.diagnostic_setting_name
    target_resource_id             = "${azurerm_storage_account.sa.id}/${each.value}Services/default"
    log_analytics_workspace_id     = var.log_analytics_workspace_id
    log_analytics_destination_type = var.log_analytics_destination_type
  
    dynamic "enabled_log" {
      for_each = toset(var.diagnostic_setting_enabled_log_categories)
  
      content {
        category = enabled_log.value
      }
    }
  
    metric {
      category = "Capacity"
      enabled  = false
  
      retention_policy {
        days    = 0
        enabled = false
      }
    }
  
    metric {
      category = "Transaction"
      enabled  = false
  
      retention_policy {
        days    = 0
        enabled = false
      }
    }
}