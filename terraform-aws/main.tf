# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

locals {
  cluster_name = "${var.cluster_prefix}-${random_string.suffix.result}"
  zones = ["1", "2", "3"]
}

provider "aws" {
  region = var.region
}

# Filter out local zones, which are not currently supported 
# with managed node groups
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "jphaugla-vpc"

  cidr = var.cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
     coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "jphaugla-group-1"

      instance_types = ["t3.xlarge"]
      capacity_type = "ON_DEMAND"

      min_size     = 1
      max_size     = 3
      desired_size = 3
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
   }

    two = {
      name = "jphaugla-group-2"

      instance_types = ["t3.xlarge"]
      capacity_type = "ON_DEMAND"

      min_size     = 1
      max_size     = 2
      desired_size = 1
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
}


# https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.39.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

#  Define a storage class referencing the EBS CSI driver
resource "kubernetes_storage_class" "ebs_csi_sc" {
  metadata {
    name = "ebs-csi-sc"
  }

  storage_provisioner = "ebs.csi.aws.com"
  parameters = {
    type = "gp2" # Adjust type for desired performance (e.g., st1 for high throughput)
  }
}

# Create a persistent volume claim referencing the storage class
resource "kubernetes_persistent_volume_claim" "jphaugland_pvc" {
  metadata {
    name = "jphaugland-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    storage_class_name = kubernetes_storage_class.ebs_csi_sc.metadata[0].name
  }
}
