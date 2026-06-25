resource "azurerm_public_ip" "public_ip" {
  for_each = var.PIP
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
}