data "azurerm_public_ip" "pip" {
  for_each            = var.PIP
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_virtual_machine" "vm" {
  for_each            = var.VM
  name                = each.value.vm_name 
  resource_group_name = each.value.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  for_each            = var.VN
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}