resource "azurerm_resource_group" "basics-rg" {
  name     = var.resource_group_name
  location = var.location
  tags = merge(var.resource_group_name,var.tags)
}
