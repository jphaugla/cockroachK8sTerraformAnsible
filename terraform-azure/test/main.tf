provider "google"{
deletion_protection=false
}
module "mymodule" {
   source               = "../"
   location_1 = "eastus2"
   prefix = "jph-k8"
   aks_node_count = 3
   azure_resource_group = "jhaugland-aks-rg"
   cockroach_namespace = "cockroach"
   kubeconfig = "/Users/jasonhaugland/.kube/config"
}
