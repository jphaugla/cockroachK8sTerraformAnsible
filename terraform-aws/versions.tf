terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    time = {
      source = "hashicorp/time"
      version = "0.9.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      # version pin optional
    }
  }


  required_version = ">= 0.14"
}
