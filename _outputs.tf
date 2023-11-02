output "account_id" {
  description = "The ID of this Storage account."
  value       = azurerm_storage_account.sa.id
}

output "account_name" {
  description = "The name of this Storage account."
  value       = azurerm_storage_account.sa.name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Storage Account."
  value       = try(azurerm_storage_account.sa.identity[0].principal_id, null)
}

output "account_tier" {
  description = "The Tier of this Storage Account."
  value       = azurerm_storage_account.sa.account_tier
}

output "account_kind" {
  description = "The Kind of this Storage Account."
  value       = azurerm_storage_account.sa.account_kind
}

output "account_replication_type" {
  description = "The type of replication to use for this Storage Account."
  value       = azurerm_storage_account.sa.account_replication_type
}

output "blob_endpoint" {
  description = "The endpoint URL for this Blob Storage."
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The secondary endpoint URL for this Blob Storage."
  value       = azurerm_storage_account.sa.secondary_blob_endpoint
}

output "queue_endpoint" {
  description = "The endpoint URL for this Queue Storage."
  value       = azurerm_storage_account.sa.primary_queue_endpoint
}

output "secondary_queue_endpoint" {
  description = "The secondary endpoint URL for this Queue Storage."
  value       = azurerm_storage_account.sa.secondary_queue_endpoint
}

output "table_endpoint" {
  description = "The endpoint URL for this Table Storage."
  value       = azurerm_storage_account.sa.primary_table_endpoint
}

output "secondary_table_endpoint" {
  description = "The secondary endpoint URL for this Table Storage."
  value       = azurerm_storage_account.sa.secondary_table_endpoint
}

output "file_endpoint" {
  description = "The endpoint URL of this File Storage."
  value       = azurerm_storage_account.sa.primary_file_endpoint
}

output "secondary_file_endpoint" {
  description = "The secondary endpoint URL of this File Storage."
  value       = azurerm_storage_account.sa.secondary_file_endpoint
}

output "primary_access_key" {
  description = "The primary access key for this Storage account."
  value       = azurerm_storage_account.sa.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for this Storage account."
  value       = azurerm_storage_account.sa.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for this Storage account."
  value       = azurerm_storage_account.sa.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string for this Storage account."
  value       = azurerm_storage_account.sa.secondary_connection_string
  sensitive   = true
}