
locals {
  values_path = "${var.config_path}/${var.values_directory}"

  applications = nonsensitive(toset([
    for file in fileset(var.config_path, "${var.group}/*.yaml") :
    yamldecode(templatefile("${var.config_path}/${file}", var.variables))
  ]))
}
