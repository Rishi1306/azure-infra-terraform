resource "azurerm_mssql_server" "SQL_server" {
    for_each = var.SQLS
  name                         = each.value.server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.secret[
    each.value.username_key
  ].value
  administrator_login_password = data.azurerm_key_vault_secret.secret[
    each.value.password_key
  ].value
}