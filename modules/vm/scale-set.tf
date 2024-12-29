# locals {
#   first_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDN94u4Sy/6DoCoYTF13Or6QE1e8lOzXlPDAKNA/HbDSSdbvodWzZXFMr8keIVItjeQNwz47R1skh2AdW7Pmg4HmFdNKPlDkPloSxaZM/v2UfoLWyefsFBfX9nk7885t85MAB0bH3JY1ePt0vcZe5DCnKaVXuI2ZExbm5Zv8oa3LZVLp3tyabKztBofH6WoVwxXJwEGBLBFcHEsvQlM3D6IG/rl3/k1lbQa6CogCXSpdCiK8+VO5PkSOI9iOLLTcu2rmwzuQdKXhY9MKSodUL2LXC455ZWNhQbvtKhW/7JrrryDzBLY8ELK0bebw9/C4DHtgqSyISrVUhgbAQkrrCsRnLsXcDVJeBrkwlX4W1g5bZh5YnFBfh4RJBi1R7ueJAkR3Xhu8C5En3FY7zgFmNQmIqCqdY0jUsa8+6QtbjyJUTPJ/XZkaB3uVZmSjLIuwgHlIz+X9HkHQOsk/Wqyew9aLRa4Ri26MlITj8rkTZIzh46y7IsgR7uYcumRUOVhvM0= argadepp@gmail.com"
# }


# # Data template Bash bootstrapping file
# data "template_file" "linux-vm-cloud-init" {
#   template = file("azure-user-data.sh")
# }
# resource "azurerm_linux_virtual_machine_scale_set" "nginx-sc-set" {
# name="${var.vm_name}-scale-set"
# resource_group_name = var.resource_group_name
# location = var.location
# instances = 2
# admin_username = var.admin_username

# sku                 = "Standard_F2"

#   admin_ssh_key {
#     username   = var.admin_username
#     public_key = local.first_public_key
    
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
    
#   }

#   network_interface {
#     name = "${var.vm_name}-interface"
#     primary = true
#     network_security_group_id = var.nsg-id
#     ip_configuration {
#       name      = "internal"
#       primary   = true
#       subnet_id = var.subnet_id
#       load_balancer_backend_address_pool_ids = [var.pool-id]
      
#     }
#   }


#   # Adding user_data for bootstrapping the instance
#   user_data = base64encode(data.template_file.linux-vm-cloud-init.rendered)
# }