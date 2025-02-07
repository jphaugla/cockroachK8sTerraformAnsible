provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "kubernetes" {
  alias                     = "region_1"
  host                      = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].host
  username                  = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].username
  password                  = azurerm_kubernetes_cluster.aks_region_1.kube_config[0].password
  client_certificate        = base64decode(azurerm_kubernetes_cluster.aks_region_1.kube_config[0].client_certificate)
  client_key                = base64decode(azurerm_kubernetes_cluster.aks_region_1.kube_config[0].client_key)
  cluster_ca_certificate    = base64decode(azurerm_kubernetes_cluster.aks_region_1.kube_config[0].cluster_ca_certificate)

}

#provider "null" {
#  # Configuration options
#}
#
#provider "tls" {
#  # Configuration options
#}
#
#provider "time" {
#  # Configuration options
#}
#
