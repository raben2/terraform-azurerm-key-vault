terraform module azurerm key-vault
==================================

Use this module to create key-vault instances for your services running on azure

## Requirements

| Name | Version |
|------|---------|
| azurerm | ~> 2.23.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.23.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_policies | Define a Azure Key Vault access policy | <pre>map(object({<br>    object_id               = string<br>    key_permissions         = list(string)<br>    secret_permissions      = list(string)<br>    certificate_permissions = list(string)<br>    storage_permissions     = list(string)<br>  }))</pre> | `{}` | no |
| allowed\_subnet\_ids | List of subnet ids allowed to access the vault | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| cert\_permissions\_all | List of full certificate permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list(string)` | <pre>[<br>  "create",<br>  "delete",<br>  "deleteissuers",<br>  "get",<br>  "getissuers",<br>  "import",<br>  "list",<br>  "listissuers",<br>  "managecontacts",<br>  "manageissuers",<br>  "purge",<br>  "recover",<br>  "setissuers",<br>  "update",<br>  "backup",<br>  "restore"<br>]</pre> | no |
| deployment\_enabled | Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault | `bool` | `false` | no |
| disk\_encryption | Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys | `bool` | `true` | no |
| environment | virtual environment for the instance | `string` | `"dev"` | no |
| key\_permissions\_all | List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list(string)` | <pre>[<br>  "backup",<br>  "create",<br>  "decrypt",<br>  "delete",<br>  "encrypt",<br>  "get",<br>  "import",<br>  "list",<br>  "purge",<br>  "recover",<br>  "restore",<br>  "sign",<br>  "unwrapKey",<br>  "update",<br>  "verify",<br>  "wrapKey"<br>]</pre> | no |
| name | main name for the instance | `string` | `"KV"` | no |
| purge\_protection | Enable/Disable purge protection | `bool` | `false` | no |
| resource\_group\_name | n/a | `string` | `""` | no |
| secrets | Define Azure Key Vault secrets | <pre>map(object({<br>    value = string<br>  }))</pre> | `{}` | no |
| secrets\_permissions\_all | List of full secret permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list(string)` | <pre>[<br>  "backup",<br>  "delete",<br>  "get",<br>  "list",<br>  "purge",<br>  "recover",<br>  "restore",<br>  "set"<br>]</pre> | no |
| sku\_name | Select Standard or Premium SKU | `string` | `"standard"` | no |
| soft\_delete | Enable/Disable soft delete | `bool` | `false` | no |
| storage\_permissions\_all | List of full storage permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey. | `list(string)` | <pre>[<br>  "backup",<br>  "delete",<br>  "deletesas",<br>  "get",<br>  "getsas",<br>  "list",<br>  "listsas",<br>  "purge",<br>  "recover",<br>  "regeneratekey",<br>  "restore",<br>  "set",<br>  "setsas",<br>  "update"<br>]</pre> | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| template\_deployment\_enabled | Allow Azure Deployments to retrieve secrets from the Azure Key Vault | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| key-vault-id | Key Vault ID |
| key-vault-url | Key Vault URI |

## Development

### Prerequisites

- [terraform](https://learn.hashicorp.com/terraform/getting-started/install#installing-terraform)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [pre-commit](https://pre-commit.com/#install)

### Configurations

- Configure pre-commit hooks
```sh
pre-commit install
```
