resource "azurerm_resource_group" "basics-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = default_tags
}

output "merged_tags" {
  value = merge(var.default_tags, var.tags)
}

resource "azurerm_resource_group" "example" {
  name     = "testResourceGroup1"
  location = var.location

  tags = {
    environment = "Production"
  }
}