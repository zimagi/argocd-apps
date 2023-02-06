
locals {
  values_path = "${var.config_path}/${var.values_directory}"

  applications = [
    for file in fileset(var.config_path, "${var.group}/*.yaml") :
    yamldecode(templatefile("${var.config_path}/${file}", var.variables))
  ]
  application_index = {
    for config in local.applications : config.name => config
  }
}
