variable "prefix" {
  description = "A prefix used for all resources in this example"
}

variable "location_1" {
  description = "The Azure Region in which all resources in this example should be provisioned"
}

variable "location_1_vnet_address_space" {
  description = "The Azure VNET address space for first location"
  default = ["10.1.0.0/16"]
}


variable "location_1_aks_subnet" {
  description = "The Azure VNET address space for first location"
  default = ["10.1.0.0/22"]
}

variable "aks_pool_name" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "nodepool"
}

variable "aks_vm_size" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "Standard_D8s_v3"
}

variable "aks_node_count" {
  description = "The number of azure crdb nodes"
  default = 3
}

variable "cockroachdb_version" {
  description = "Cockroach version to install"
  default = "v23.2.5"
}

variable "cockroachdb_pod_cpu" {
  description = "The number of CPUS for the azure nodes"
  default = "4"
}

variable "cockroachdb_pod_memory" {
  description = "The memory allocated for CRDB"
  default = "8Gi"
}

variable "cockroachdb_storage" {
  description = "The cockroachDB storage ammount"
  default = "50Gi"
}

variable "statfulset_replicas" {
  description = "number of statefulset replicas"
  default = 3
}

variable "azure_resource_group" {
  description = "the azure resource group to use for the AKS infrastructure"
  default = "jhaugland-aks-rg"
}

variable "cockroach_namespace" {
  description = "the k8s namespace for the cockroach workload"
  default = "cockroach"
}

variable "kubeconfig" {
  description = "the full path to the .kube config file"
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

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = ""
}
