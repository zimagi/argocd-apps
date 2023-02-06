#
# This is not a great solution but Terraform doesn't support dependency chaining within resource blocks for concurrency reasons
#
# Support up to 10 deployment stages (which should be plenty)
#
module "release_0" {
  count = length(var.groups) > 0 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[0]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    helm_release.argocd
  ]
}

module "release_1" {
  count = length(var.groups) > 1 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[1]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_0
  ]
}

module "release_2" {
  count = length(var.groups) > 2 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[2]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_1
  ]
}

module "release_3" {
  count = length(var.groups) > 3 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[3]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_2
  ]
}

module "release_4" {
  count = length(var.groups) > 4 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[4]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_3
  ]
}

module "release_5" {
  count = length(var.groups) > 5 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[5]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_4
  ]
}

module "release_6" {
  count = length(var.groups) > 6 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[6]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_5
  ]
}

module "release_7" {
  count = length(var.groups) > 7 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[7]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_6
  ]
}

module "release_8" {
  count = length(var.groups) > 8 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[8]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_7
  ]
}

module "release_9" {
  count = length(var.groups) > 9 ? 1 : 0

  source           = "./release"
  config_path      = var.config_path
  values_directory = var.values_directory

  group     = var.groups[9]
  secrets   = local.secrets
  config    = local.config
  variables = local.variables

  default_repository = var.default_repository
  default_chart      = var.default_chart
  default_path       = var.default_path
  default_version    = var.default_version

  depends_on = [
    module.release_8
  ]
}
