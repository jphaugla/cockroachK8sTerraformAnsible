# versions.tf 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.99.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.9"
    }
  }

  required_version = ">= 0.14"
}
