locals {
  context_list = join("", formatlist(";%s;:;gke_${var.gcp_project}_%s_${var.cluster_prefix}-%s;,", var.zone, var.zone, var.region))
  zones_list        = join("", formatlist(";%s;:;%s;,", var.zone, var.region))
}

module "region1" {
   source               = "../terraform"
   gcp_project          = var.gcp_project
   gcp_credentials_file = var.gcp_credentials_file
   gcp_kubeconfig       = var.gcp_kubeconfig
   cidr                 = var.cidr[0]
   region               = var.region[0]
   cluster_name_final   = "${var.cluster_prefix}-${var.region[0]}"
   zone                 = "${var.zone[0]}"
   cockroach_namespace  = var.cockroach_namespace
   gke_release_channel  = var.gke_release_channel
   run_k8s_cockroach    = var.run_k8s_cockroach
}
module "region2" {
   source               = "../terraform"
   gcp_project          = var.gcp_project
   gcp_credentials_file = var.gcp_credentials_file
   gcp_kubeconfig       = var.gcp_kubeconfig
   cidr                 = var.cidr[1]
   region               = var.region[1]
   cluster_name_final   = "${var.cluster_prefix}-${var.region[1]}"
   zone                 = "${var.zone[1]}"
   cockroach_namespace  = var.cockroach_namespace
   gke_release_channel  = var.gke_release_channel
   run_k8s_cockroach    = var.run_k8s_cockroach
}
module "region3" {
   source               = "../terraform"
   gcp_project          = var.gcp_project
   gcp_credentials_file = var.gcp_credentials_file
   gcp_kubeconfig       = var.gcp_kubeconfig
   cidr                 = var.cidr[2]
   region               = var.region[2]
   cluster_name_final   = "${var.cluster_prefix}-${var.region[2]}"
   zone                 = "${var.zone[2]}"
   cockroach_namespace  = var.cockroach_namespace
   gke_release_channel  = var.gke_release_channel
   run_k8s_cockroach    = var.run_k8s_cockroach
}
