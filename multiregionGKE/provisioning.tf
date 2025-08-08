resource "null_resource" "provision" {

    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "local-exec" {
        working_dir = "../../ansible-multiregion/"
        command = "ansible-playbook  -vv --extra-vars cluster_state=present playbook.yml -e 'cluster_prefix=${var.cluster_prefix}'  -e 'context_list=${local.context_list}' -e 'gcp_project=${var.gcp_project}' -e 'KUBECONFIG=gkeconfig' -e 'cockroach_namespace=${var.cockroach_namespace}' -e 'is_gke=true' -e 'is_aks=false' -e 'zones_list=${local.zones_list}' -e 'ansible_venv=${var.ansible_venv}'"
    }

    depends_on = [
module.region1, 
module.region3.node_pool_id,
module.region2, 
module.region2.node_pool_id,
module.region3, 
module.region3.node_pool_id
    ]
}
