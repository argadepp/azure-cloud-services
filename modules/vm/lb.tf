resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "example-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                 = "${var.prefix}-ip-config"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}



resource "azurerm_lb_backend_address_pool" "example" {
  name                = "example-backend-pool"
  loadbalancer_id     = azurerm_lb.example.id
}

resource "azurerm_lb_probe" "example" {
  name                = "example-probe"
  loadbalancer_id     = azurerm_lb.example.id
  protocol            = "Http"
  request_path        = "/"
  port                = 80
}
