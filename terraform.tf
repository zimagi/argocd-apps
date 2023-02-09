
terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

#
# Kubernetes provider setup
#
provider "kubernetes" {
  config_path = var.kube_config
}
provider "kubectl" {
  config_path = var.kube_config
}

#
# Helm provider setup
#
provider "helm" {
  kubernetes {
    config_path = var.kube_config
  }
}
