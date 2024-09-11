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
