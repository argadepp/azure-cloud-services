locals {
  first_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDN94u4Sy/6DoCoYTF13Or6QE1e8lOzXlPDAKNA/HbDSSdbvodWzZXFMr8keIVItjeQNwz47R1skh2AdW7Pmg4HmFdNKPlDkPloSxaZM/v2UfoLWyefsFBfX9nk7885t85MAB0bH3JY1ePt0vcZe5DCnKaVXuI2ZExbm5Zv8oa3LZVLp3tyabKztBofH6WoVwxXJwEGBLBFcHEsvQlM3D6IG/rl3/k1lbQa6CogCXSpdCiK8+VO5PkSOI9iOLLTcu2rmwzuQdKXhY9MKSodUL2LXC455ZWNhQbvtKhW/7JrrryDzBLY8ELK0bebw9/C4DHtgqSyISrVUhgbAQkrrCsRnLsXcDVJeBrkwlX4W1g5bZh5YnFBfh4RJBi1R7ueJAkR3Xhu8C5En3FY7zgFmNQmIqCqdY0jUsa8+6QtbjyJUTPJ/XZkaB3uVZmSjLIuwgHlIz+X9HkHQOsk/Wqyew9aLRa4Ri26MlITj8rkTZIzh46y7IsgR7uYcumRUOVhvM0= argadepp@gmail.com"
}


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
    name                 = "example-frontend"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}


resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-vm-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # or "Static" if you want a fixed public IP
  sku                 = "Basic"  # Can be "Standard" for advanced scenarios

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

resource "azurerm_lb_rule" "example" {
  name                           = "example-lb-rule"
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "example-frontend"
  probe_id                       = azurerm_lb_probe.example.id
}

resource "azurerm_network_interface" "example" {

  name                = "example-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "example-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

# Data template Bash bootstrapping file
data "template_file" "linux-vm-cloud-init" {
  template = file("azure-user-data.sh")
}
#Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    azurerm_network_interface.example.id
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




resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.nsg-id
}