data "azurerm_key_vault" "kv" {
  for_each = var.KV
  name                = each.value.vault_name
  resource_group_name = each.value.resource_group_name
}