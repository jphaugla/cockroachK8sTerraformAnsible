resource "null_resource" "provision" {

    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "local-exec" {
        working_dir = "../../ansible/"
        command = "ansible-playbook  -vv --extra-vars cluster_state=present playbook.yml -e 'cluster_name=${google_container_cluster.primary.name}'  -e 'gcp_zone=${var.zone}' -e 'gcp_project=${var.gcp_project}' -e 'KUBECONFIG=gkeconfig' -e 'cockroach_namespace=cockroach'"
    }

    depends_on = [
google_container_node_pool.primary_nodes
    ]
}
