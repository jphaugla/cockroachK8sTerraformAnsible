module "mymodule" {
   source               = "../"
   location_1 = "eastus2"
   prefix = "jph"
   owner = "jhaugland"
   aks_node_count = 3
   azure_resource_group = "jhaugland-aks-rg"
   cockroach_namespace = "cockroach"
   kubeconfig = "/Users/jasonhaugland/.kube/config"
   run_k8s_cockroach = "yes"
   dbadmin_user_name    = "jhaugland"
   dbadmin_user_password = "jasonrocks"
}

output "resource_group_name" {
  value = module.mymodule.resource_group_name
}

output "kubernetes_cluster_name_region_1" {
  value = module.mymodule.kubernetes_cluster_name_region_1
}
