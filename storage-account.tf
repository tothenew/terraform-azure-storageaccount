resource "azurerm_storage_account" "sa" {
  name                = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only        = var.enable_https_traffic_only
  min_tls_version                  = var.min_tls_version
  shared_access_key_enabled        = var.shared_access_key_enabled
  is_hns_enabled                   = var.is_hns_enabled
  queue_encryption_key_type        = var.queue_encryption_key_type
  table_encryption_key_type        = var.table_encryption_key_type
  allow_nested_items_to_be_public  = var.allow_blob_public_access
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled

  tags = merge(local.common_tags, tomap({
    "Name" : local.project_name_prefix
  }))

  dynamic "blob_properties" {
    # Check if blob properties is enabled and supported.
    for_each = (
      var.blob_properties != null
      && !local.is_premium_file_storage
    ) ? [var.blob_properties] : []

    content {
      # Check if versioning is supported.
      versioning_enabled = (
        !local.is_premium_data_lake_storage
        && !local.is_premium_gpv2_storage
        && !local.is_standard_data_lake_storage
      ) ? blob_properties.value["versioning_enabled"] : false

      # Check if change feed is supported.
      change_feed_enabled = (
        !local.is_premium_data_lake_storage
        && !local.is_premium_gpv2_storage
        && !local.is_standard_data_lake_storage
      ) ? blob_properties.value["change_feed_enabled"] : false

      delete_retention_policy {
        days = blob_properties.value["delete_retention_policy_days"]
      }

      container_delete_retention_policy {
        days = blob_properties.value["container_delete_retention_policy_days"]
      }

      dynamic "restore_policy" {
        # Check if restore policy is enabled and supported.
        for_each = (
          blob_properties.value["restore_policy_days"] > 0
          && !local.is_premium_block_blob_storage
          && !local.is_premium_data_lake_storage
          && !local.is_premium_gpv2_storage
          && !local.is_standard_blob_storage
          && !local.is_standard_data_lake_storage
        ) ? [blob_properties.value["restore_policy_days"]] : []

        content {
          days = restore_policy.value
        }
      }

      dynamic "cors_rule" {
        for_each = blob_properties.value["cors_rules"]

        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }
    }
  }

  dynamic "share_properties" {
    # Check if share properties is enabled and supported.
    for_each = (
      var.share_properties != null
      && !local.is_premium_block_blob_storage
      && !local.is_premium_data_lake_storage
      && !local.is_premium_gpv2_storage
      && !local.is_standard_blob_storage
      && !local.is_standard_data_lake_storage
    ) ? [var.share_properties] : []

    content {
      retention_policy {
        days = share_properties.value["retention_policy_days"]
      }
    }
  }

  dynamic "queue_properties" {
    # Check if queue properties is enabled and supported.
    for_each = (
      var.queue_properties != null
      && !local.is_premium_block_blob_storage
      && !local.is_premium_data_lake_storage
      && !local.is_premium_file_storage
      && !local.is_premium_gpv2_storage
      && !local.is_standard_blob_storage
    ) ? [var.queue_properties] : []

    content {
      logging {
        delete                = queue_properties.value["logging_delete"]
        read                  = queue_properties.value["logging_read"]
        write                 = queue_properties.value["logging_write"]
        version               = queue_properties.value["logging_version"]
        retention_policy_days = queue_properties.value["logging_retention_policy_days"]
      }

      hour_metrics {
        enabled               = queue_properties.value["hour_metrics_enabled"]
        include_apis          = queue_properties.value["hour_metrics_include_apis"]
        version               = queue_properties.value["hour_metrics_version"]
        retention_policy_days = queue_properties.value["hour_metrics_retention_policy_days"]
      }

      minute_metrics {
        enabled               = queue_properties.value["minute_metrics_enabled"]
        include_apis          = queue_properties.value["minute_metrics_include_apis"]
        version               = queue_properties.value["minute_metrics_version"]
        retention_policy_days = queue_properties.value["minute_metrics_retention_policy_days"]
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  network_rules {
    default_action             = var.network_rules_default_action
    bypass                     = var.network_rules_bypass
    ip_rules                   = var.network_rules_ip_rules
    virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []
    content {
      name          = custom_domain.value["name"]
      use_subdomain = custom_domain.value["use_subdomain"]
    }
  }
}