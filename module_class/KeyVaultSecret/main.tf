resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = var.KVS
  name         = each.value.secretname
  value        = each.value.secretvalue
  key_vault_id = data.azurerm_key_vault.kv[each.value.keyvault_key].id
}
