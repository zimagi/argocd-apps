
#
# Helm provider setup
#
provider "helm" {
  kubernetes {
    config_path = var.kube_config
  }
}
