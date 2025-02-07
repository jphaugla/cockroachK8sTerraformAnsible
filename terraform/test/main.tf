provider "google"{
deletion_protection=false 
}

module "mymodule" {
   source 		= "../"
   gcp_project          = "cockroach-jhaugland"
   gcp_credentials_file = "/Users/jasonhaugland/.config/gcloud/application_default_credentials.json"
   gcp_kubeconfig       = "/Users/jasonhaugland/.kube/config"
   cidr 		=  "10.3.0.0/16"
   region 		= "us-central1"
   cluster_name_final   = "jph-gke"
   zone 		= "us-central1-a"
   cockroach_namespace  = "cockroach"
   gke_release_channel  = "STABLE"
   run_k8s_cockroach    = "yes"
}
