
# Define an Azure Kubernetes Service cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster-name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "akscluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}

# Output the Kubernetes config
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
