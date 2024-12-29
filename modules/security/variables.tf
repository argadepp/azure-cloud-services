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


variable "name" {
  
}
# Define the security rules as a list of objects
variable "security_rules" {
  description = "A list of security rules to apply to the NSG."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                  = string
    source_port_range         = string
    destination_port_range    = string
    source_address_prefix     = string
    destination_address_prefix = string
  }))
  default = []
}