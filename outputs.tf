output "key-vault-id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.secrets.id
}
output "key-vault-url" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.secrets.vault_uri
}

