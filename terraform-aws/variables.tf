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
