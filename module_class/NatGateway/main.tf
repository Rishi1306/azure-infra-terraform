resource "azurerm_nat_gateway" "nat_gateway" {
    for_each = var.NG
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_association" {
    for_each = var.NG
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway[each.key].id
  public_ip_address_id = data.azurerm_public_ip.pip[each.value.pip_key].id
}

resource "azurerm_subnet_nat_gateway_association" "sub_nat_association" {
    for_each = var.NG
  subnet_id      = data.azurerm_subnet.subnet[each.value.subnet_key].id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway[each.key].id
}