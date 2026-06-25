resource "azurerm_network_security_group" "nsg" {
  for_each            = var.VM
  name                = "${each.value.vm_name}-nsg"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {

  for_each = var.VM

  name                = "${each.value.vm_name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id = data.azurerm_subnet.subnet[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  for_each                  = var.VM
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

resource "azurerm_virtual_machine" "virtual_machine" {

  for_each = var.VM

  name                = each.value.vm_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  vm_size = each.value.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true


  storage_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  storage_os_disk {
    name              = each.value.os_disk_name
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.os.computer_name
    admin_username = data.azurerm_key_vault_secret.secret[
      each.value.username_key
    ].value

    admin_password = data.azurerm_key_vault_secret.secret[
      each.value.password_key
    ].value
}

  os_profile_linux_config {
    disable_password_authentication = false
  }
}