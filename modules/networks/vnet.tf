resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet-cidr]
  tags = merge(var.default_tags, var.tags)
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet-name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet-cidr]
  
}