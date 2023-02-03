
output "yaml" {
  value = yamlencode(module.applications.merged)
}
