resource "null_resource" "provision" {

    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "local-exec" {
        working_dir = "../../ansible/"
        command = "ansible-playbook  -v --extra-vars cluster_state=present playbook.yml -e 'cluster_name=${google_container_cluster.primary.name}'  -e 'gcp_zone=${var.zone}' -e 'gcp_project=${var.gcp_project}' -e 'KUBECONFIG=${var.gcp_kubeconfig}' -e 'cockroach_namespace=cockroach' -e 'is_gke=true' -e 'is_aks=false' -e 'is_eks=false' -e 'run_k8s_cockroach=${var.run_k8s_cockroach}'"
    }

    depends_on = [
google_container_node_pool.primary_nodes
    ]
}
