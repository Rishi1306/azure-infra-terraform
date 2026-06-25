data "azurerm_subnet" "subnet" {
  for_each = var.SN
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
    for_each = var.PIP
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}