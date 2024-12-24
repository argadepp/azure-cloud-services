resource "azurerm_resource_group" "basics-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(var.default_tags, var.tags)
}
