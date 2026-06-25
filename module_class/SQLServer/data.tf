data "azurerm_key_vault" "kv" {
  for_each = var.KV
  name = each.value.vault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "secret" {
  for_each = var.KVS
  name = each.value.secretname
  key_vault_id = data.azurerm_key_vault.kv[
    each.value.keyvault_key
  ].id
}