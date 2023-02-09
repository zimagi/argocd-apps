
terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

#
# Kubernetes provider setup
#
provider "kubectl" {
  config_path = var.kube_config
}
