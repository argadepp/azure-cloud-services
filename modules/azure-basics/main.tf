resource "azurerm_resource_group" "basics-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = default_tags
}

output "merged_tags" {
  value = merge(var.default_tags, var.tags)
}

resource "azurerm_resource_group" "network-rg" {
  name     = "network-${var.resource_group_name}"
  location = var.location
  tags     = default_tags
}
