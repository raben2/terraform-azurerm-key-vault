variable "name" {
  description = "main name for the instance"
  type        = string
  default     = "KV"
}

variable "environment" {
  description = "virtual environment for the instance"
  type        = string
  default     = "dev"
}
variable "resource_group_name" {
  description = "name of the main resource group"
  type        = string
  default     = ""
}
variable "sku_name" {
  type        = string
  description = "Select Standard or Premium SKU"
  default     = "standard"
}

variable "deployment_enabled" {
  type        = bool
  description = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault"
  default     = false
}

variable "disk_encryption" {
  type        = bool
  description = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys"
  default     = true
}

variable "template_deployment_enabled" {
  type        = bool
  description = "Allow Azure Deployments to retrieve secrets from the Azure Key Vault"
  default     = false
}

variable "soft_delete" {
  type        = bool
  description = "Enable/Disable soft delete"
  default     = false
}

variable "purge_protection" {
  type        = bool
  description = "Enable/Disable purge protection"
  default     = false
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "List of subnet ids allowed to access the vault"
  default     = [""]
}

variable "key_permissions_all" {
  type        = list(string)
  description = "List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge",
  "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "secrets_permissions_all" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default     = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "cert_permissions_all" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
  "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"]
}

variable "storage_permissions_all" {
  type        = list(string)
  description = "List of full storage permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas",
  "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}


variable "access_policies" {
  type = map(object({
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "Define a Azure Key Vault access policy"
  default     = {}
}


variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default     = {}
}
