provider "azurerm" {
  version = "~> 2.23.0"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
data "azurerm_resource_group" "main" {
  name = data.azurerm_resource_group.main.name
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "secrets" {
  name                            = format("%s%skeyVault", var.name, var.environment)
  location                        = data.azurerm_resource_group.main.location
  resource_group_name             = data.azurerm_resource_group.main.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption     = var.disk_encryption
  soft_delete_enabled             = var.soft_delete
  purge_protection_enabled        = var.purge_protection
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.deployment_enabled
  enabled_for_template_deployment = var.template_deployment_enabled

  tags = var.tags

  network_acls {
    default_action             = "Allow"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

}

resource "azurerm_key_vault_access_policy" "default" {
  key_vault_id = azurerm_key_vault.secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.key_permissions_all
  secret_permissions      = var.secrets_permissions_all
  certificate_permissions = var.cert_permissions_all
  storage_permissions     = var.storage_permissions_all
}

resource "azurerm_key_vault_access_policy" "custom" {
  for_each     = var.access_policies
  key_vault_id = azurerm_key_vault.secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  lifecycle {
    create_before_destroy = true
  }
  object_id               = lookup(each.value, "object_id")
  key_permissions         = lookup(each.value, "key_permissions")
  secret_permissions      = lookup(each.value, "secret_permissions")
  certificate_permissions = lookup(each.value, "certificate_permissions")
  storage_permissions     = lookup(each.value, "storage_permissions")
}

resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  key_vault_id = azurerm_key_vault.secrets.id
  name         = each.key
  value        = lookup(each.value, "value") != "" ? lookup(each.value, "value") : random_password.password[each.key].result
  tags         = var.tags
  depends_on = [
    azurerm_key_vault.secrets,
    azurerm_key_vault_access_policy.default,
  ]
}

resource "random_password" "password" {
  for_each    = var.secrets
  length      = 20
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2

  keepers = {
    name = each.key
  }
}
