terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
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
  }

  required_version = ">= 0.14"
}
