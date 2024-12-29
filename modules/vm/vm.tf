resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-vm-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # or "Static" if you want a fixed public IP
  sku                 = "Basic"  # Can be "Standard" for advanced scenarios

}


resource "azurerm_network_interface" "vm-interface" {
  resource_group_name = var.resource_group_name
  name = "${var.prefix}-vm-interface"
  location = "${var.location}"
  
  ip_configuration {
    name = "${var.prefix}-ip-config"
    private_ip_address_allocation = "Dynamic"
    subnet_id = "${var.subnet_id}"
    public_ip_address_id = azurerm_public_ip.public_ip.id
    
  }
  
}

resource "azurerm_network_interface_backend_address_pool_association" "http-rule" {
  ip_configuration_name = "${var.prefix}-ip-config"
  network_interface_id = azurerm_network_interface.vm-interface.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
  
}


resource "azurerm_network_interface_security_group_association" "nsg-interface" {
  network_interface_id = azurerm_network_interface.vm-interface.id
  network_security_group_id = var.nsg-id
}

resource "azurerm_lb_nat_rule" "example" {
  name                           = "${var.prefix}-ip-config"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.prefix}-ip-config"
}

resource "azurerm_network_interface_nat_rule_association" "http-rule-asc" {
  ip_configuration_name = "${var.prefix}-ip-config"
  network_interface_id = azurerm_network_interface.vm-interface.id
  nat_rule_id = azurerm_lb_nat_rule.example.id
  depends_on = [azurerm_lb_nat_rule.example]
}



#Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    azurerm_network_interface.vm-interface.id
  ]
  size               = var.vm_size
  admin_username     = var.admin_username
  
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }


  provisioner "remote-exec" {
    connection {
      host = azurerm_public_ip.public_ip.ip_address
      user = var.admin_username
      type = "ssh"
      private_key =  file("~/.ssh/id_rsa")
    }

    inline = [
      # Update the system

     "sudo apt-get update -y",
     "sudo apt-get install -y nginx",
     "sudo systemctl enable nginx",
     "sudo systemctl start nginx"
    ]
  }



  tags = merge(var.default_tags, var.tags)
}

