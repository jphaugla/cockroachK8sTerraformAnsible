# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_prefix" {
  description = "Cluster prefix to name CRDB cluster and the EKS cluster"
  type        = string
}

variable "aws_config" {
  description = "AWS config file location"
  type        = list(string)
}

variable "aws_credentials" {
  description = "AWS credentials file location"
  type        = list(string)
}

variable "private_subnets" {
   description = "list of private subnet ranges- should be 3"
}

variable "public_subnets" {
   description = "list of public subnet ranges- should be 3"
}

variable "cidr" {
   description = "cidr set"
}

variable "cockroach_namespace" {
   description = "namespace for cockroach"
}

variable "run_k8s_cockroach" {
   description = "run the cockroach deployment in ansible"
}

variable "eks_cluster_version" {
   description = "eks cluster version"
}

variable "kubeconfig" {
   description = "location for the kubeconfig file"
   default = "/Users/jasonhaugland/.kube/config"
}

variable "eks_vm_size" {
   description = "size of the eks aws vm"
}

variable "git_home" {
   description = "home file system for the git.  This will need to include the git directory name fo cockroachK8sTerraformAnsible"
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
# ----------------------------------------
# My IP Address & SSH Key
# ----------------------------------------
variable "my_ip_address" {
  description = "Your public IP for SSH & DB ports"
  type        = string
  default     = "0.0.0.0"
}
# ----------------------------------------
# The following was created to account for NetSkope Tunneling
# ----------------------------------------
variable netskope_ips {
  description = "A list of IP CIDR ranges to allow as clients.  The IPs listed below are Netskope IP Ranges"
  default     = ["8.36.116.0/24" ,"8.39.144.0/24", "31.186.239.0/24", "163.116.128.0/17", "162.10.0.0/17"]
  type        = list(string)
}
