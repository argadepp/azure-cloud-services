output "vm_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
  description = "Public IP address of the VM"
}

# output "vm_name" {
#   value = azurerm_linux_virtual_machine.vm.name
#   description = "Name of the VM"
# }