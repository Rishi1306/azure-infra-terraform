resource "azurerm_lb" "load_balancer" {
  for_each            = var.LB
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  frontend_ip_configuration {
    name                 = "frontend-${each.value.name}"
    public_ip_address_id = data.azurerm_public_ip.pip[each.value.pip_key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_ap" {
  for_each        = var.LB
  loadbalancer_id = azurerm_lb.load_balancer[each.key].id
  name            = "bep-${each.key}"
}

locals {
  lb_vm_associations = {
    for pair in flatten([
      for lb_key, lb in var.LB : [
        for vm_key in lb.vm_keys : {
          lb_key   = lb_key
          vm_key   = vm_key
          vnet_key = lb.vnet_key
        }
      ]
    ]) : "${pair.lb_key}-${pair.vm_key}" => pair
  }
}

resource "azurerm_lb_backend_address_pool_address" "bep_addr" {
  for_each                = local.lb_vm_associations
  name                    = "${each.value.vm_key}-bp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_ap[each.value.lb_key].id 
  virtual_network_id      = data.azurerm_virtual_network.vnet[each.value.vnet_key].id 
  ip_address              = data.azurerm_virtual_machine.vm[each.value.vm_key].private_ip_address 
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.LB
  name            = "probe-${each.key}"
  loadbalancer_id = azurerm_lb.load_balancer[each.key].id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "rule" {
  for_each                       = var.LB
  name                           = "rule-${each.key}"
  loadbalancer_id                = azurerm_lb.load_balancer[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-${each.value.name}" 

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.backend_ap[each.key].id
  ]

  probe_id = azurerm_lb_probe.probe[each.key].id
}