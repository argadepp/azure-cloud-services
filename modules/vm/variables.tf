variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "East US"
}

variable "default_tags" {
  type = map(string)
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "vm_name" {
  description = "Name of the virtual machine"
  default     = "my-ssh-vm"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  default     = "~/.ssh/id_rsa.pub"
}

variable "sub_id" {
  type = string
  description = "Subscription id"
}

variable "client_id" {
  
}

variable "client_secret" {
  
}

variable "tenant_id" {
  
}

variable "prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "nsg-id" {
  
}

