provider "google"{
deletion_protection=false 
}

module "mymodule" {
   source 		= "../"
   gcp_project          = "cockroach-jhaugland"
   gcp_credentials_file = "/Users/jasonhaugland/.config/gcloud/application_default_credentials.json"
   gcp_kubeconfig       = "/Users/jasonhaugland/.kube/config"
   cidr 		=  "10.3.0.0/16"
   # this is used for allowing traffic between clusters for multi-region deployments  can be left blank in single region
   # Could also put in additional CIDR.  Note it must be a list so ["10.3.0.0/24", "10.3.1.0/24","10.3.2.0/24"]
   full_cidr 		=  ["10.3.0.0/16"]
   region 		= "us-central1"
   cluster_name_final   = "jph-gke"
   zone 		= "us-central1-a"
   cockroach_namespace  = "cockroach"
   gke_release_channel  = "STABLE"
   run_k8s_cockroach    = "yes"
   dbadmin_user_name    = "jhaugland"
   dbadmin_user_password = "jasonrocks"
}
