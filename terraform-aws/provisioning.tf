resource "null_resource" "provision" {

    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "local-exec" {
        working_dir = "../../ansible/"
        command = "ansible-playbook  -vv --extra-vars cluster_state=present playbook.yml -e 'cluster_name=${local.cluster_name}'  -e 'cockroach_namespace=cockroach' -e 'is_gke=false' -e 'is_aks=false' -e 'is_eks=true' -e 'KUBECONFIG=${var.kubeconfig}' -e 'run_k8s_cockroach=${var.run_k8s_cockroach}' -e 'region=${var.region}' -e 'git_home=${var.git_home}'"
    }

    depends_on = [
module.eks.cluster_name
    ]
}
