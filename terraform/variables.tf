variable "gcp_project"  {
    description = "gcp project to be used."
}

variable "gcp_kubeconfig"  {
    description = "gcp location for KUBECONFIG file"
}

variable "gcp_credentials_file"  {
    description = "gcp credentials file"
}

variable "cidr" { 
    description = "CIDR blocks to be used with the network."
}
variable "full_cidr" { 
    description = "CIDR blocks to be used with the network. must be a list of cidrs"
}

variable "region" {
    description = "Region to be used with the network and resources."
}

variable "cluster_name_final" {
    description = "name of the GKE cluster"
}

variable "zone" {
    description = "Zone to be used with the network and resources."
}

variable "gke_release_channel" {
    description = "The gke release channel.  Can be RAPID, REGULAR, or STABLE"
}

variable "cockroach_namespace" {
    description = "The kubernetes namespace used for the cockroach deployment"
}

variable "run_k8s_cockroach" {
  description = "run the kubernetes to set up kafka.  Set to yes for single region but for multiregion or if want to do a more custom install of cockroachDB, set to no"
}

variable "dbadmin_user_name"{
  description = "An admin with this username will be created if 'create_dbadmin_user=yes'"
  type        = string
  default     = ""
}

variable "dbadmin_user_password"{
  description = "password for the admin user"
  type        = string
  default     = ""
}
