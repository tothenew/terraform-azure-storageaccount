locals {
  project_name_prefix = var.name == "" ? terraform.workspace : var.name
  common_tags         = length(var.common_tags) == 0 ? var.default_tags : merge(var.default_tags, var.common_tags)
}

locals {
  is_premium_block_blob_storage = var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage"
  is_premium_data_lake_storage  = var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage" && var.is_hns_enabled
  is_premium_file_storage       = var.account_tier == "Premium" && var.account_kind == "FileStorage"
  is_premium_gpv2_storage       = var.account_tier == "Premium" && var.account_kind == "StorageV2"
  is_standard_blob_storage      = var.account_tier == "Standard" && var.account_kind == "BlobStorage"
  is_standard_data_lake_storage = var.account_tier == "Standard" && var.account_kind == "StorageV2" && var.is_hns_enabled
  # No need to check for "is_standard_gpv2_storage", since that is what this module is configured for by default.
}