locals {
  name = format("%s-%s", var.global_environment, var.global_name)
}

locals {
  access_config = yamldecode(file("${var.project_path}/access.yaml"))
}

locals {
  variables = sensitive({})
}