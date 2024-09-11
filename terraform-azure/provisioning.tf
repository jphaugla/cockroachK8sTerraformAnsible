resource "null_resource" "provision" {

    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "local-exec" {
        working_dir = "../../ansible/"
        command = "ansible-playbook  -vv --extra-vars cluster_state=present playbook.yml -e 'cluster_name=${azurerm_kubernetes_cluster.aks_region_1.name}'  -e 'azure_resource_group=${var.azure_resource_group}' -e 'cockroach_namespace=${var.cockroach_namespace}' -e 'is_gke=false' -e 'is_aks=true' -e 'is_eks=false' -e 'KUBECONFIG=${var.kubeconfig}' -e 'run_k8s_cockroach=${var.run_k8s_cockroach}'"
    }

    depends_on = [
azurerm_kubernetes_cluster.aks_region_1
    ]
}
