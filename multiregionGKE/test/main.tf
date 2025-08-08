module "mymodule" {
   source               = "../"
   gcp_project          = "cockroach-jhaugland"
   gcp_credentials_file = "/Users/jasonhaugland/.config/gcloud/application_default_credentials.json"
   gcp_kubeconfig       = "/Users/jasonhaugland/.kube/config"
   cidr                 =  ["10.3.0.0/24", "10.3.1.0/24","10.3.2.0/24"]
   region               = ["us-central1", "us-west1", "us-east1"]
   cluster_prefix       = "jph-gke"
   zone                 = ["us-central1-a","us-west1-a","us-east1-c"]
   cockroach_namespace  = "cockroach"
   gke_release_channel  = "STABLE"
#  this must be set to no or will run deployment on each region
   run_k8s_cockroach    = "no"
   ansible_venv = "/Users/jasonhaugland/gits/cockroachK8sTerraformAnsible/multiregionGKE/test/ansible-venv"
}
