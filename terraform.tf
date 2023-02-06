
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
provider "kubernetes" {
  config_path = "~/.kube/config"
}
provider "kubectl" {
  config_path = "~/.kube/config"
}

#
# Helm provider setup
#
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
