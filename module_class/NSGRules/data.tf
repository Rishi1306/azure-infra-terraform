data "azurerm_network_security_group" "nsg" {
  for_each            = var.NSGR                                   
  name                = each.value.network_security_group_name      
  resource_group_name = each.value.resource_group_name
}