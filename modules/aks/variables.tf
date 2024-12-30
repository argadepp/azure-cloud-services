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

variable "cluster-name" {
  
}