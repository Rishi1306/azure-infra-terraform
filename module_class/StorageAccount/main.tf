resource "azurerm_storage_account" "storage_acc" {
  for_each = var.SA
  name                    = each.value.storage_name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}