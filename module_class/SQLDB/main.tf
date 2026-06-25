resource "azurerm_mssql_database" "sql_db" {
  for_each            = var.SQLDB
  name                = each.value.DBname
  server_id         = data.azurerm_mssql_server.sql_server[each.value.sql_server_key].id
  
  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}