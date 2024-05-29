### Region_1 Outputs

output "resource_group_name" {
  value = "${var.azure_resource_group}"
}

output "kubernetes_cluster_name_region_1" {
  value = azurerm_kubernetes_cluster.aks_region_1.name
}

output "kube_config_region_1" {
  value = azurerm_kubernetes_cluster.aks_region_1.kube_config_raw
  sensitive = true
}

output "client_certificate_region_1" {
  value     = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].client_certificate
  sensitive = true
}

output "client_key_region_1" {
  value     = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate_region_1" {
  value     = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_password_region_1" {
  value     = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].password
  sensitive = true
}

output "cluster_username_region_1" {
  value     = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].username
  sensitive = true
}

output "host_region_1" {
  value     = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].host
  sensitive = true
}
