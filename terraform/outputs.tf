output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "aks_kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
