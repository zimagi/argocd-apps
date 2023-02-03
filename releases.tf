#
# For the record, I don't like this solution but Terraform doesn't support dependency chaining within resource blocks so its what we've got
#
# Support up to 10 deployment stages (which should be plenty)
#
module "release_0" {
  count = length(var.groups) > 0 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[0]
  variables = local.variables

  depends_on = [
    helm_release.argocd
  ]
}

module "release_1" {
  count = length(var.groups) > 1 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[1]
  variables = local.variables

  depends_on = [
    module.release_0
  ]
}

module "release_2" {
  count = length(var.groups) > 2 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[2]
  variables = local.variables

  depends_on = [
    module.release_1
  ]
}

module "release_3" {
  count = length(var.groups) > 3 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[3]
  variables = local.variables

  depends_on = [
    module.release_2
  ]
}

module "release_4" {
  count = length(var.groups) > 4 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[4]
  variables = local.variables

  depends_on = [
    module.release_3
  ]
}

module "release_5" {
  count = length(var.groups) > 5 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[5]
  variables = local.variables

  depends_on = [
    module.release_4
  ]
}

module "release_6" {
  count = length(var.groups) > 6 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[6]
  variables = local.variables

  depends_on = [
    module.release_5
  ]
}

module "release_7" {
  count = length(var.groups) > 7 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[7]
  variables = local.variables

  depends_on = [
    module.release_6
  ]
}

module "release_8" {
  count = length(var.groups) > 8 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[8]
  variables = local.variables

  depends_on = [
    module.release_7
  ]
}

module "release_9" {
  count = length(var.groups) > 9 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory
  apps_version     = var.argocd_apps_version

  group     = var.groups[9]
  variables = local.variables

  depends_on = [
    module.release_8
  ]
}
