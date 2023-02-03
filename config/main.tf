
module "values" {
  for_each = { for index, data in local.applications : index => data }

  source = "Invicton-Labs/deepmerge/null"
  maps = [
    for file in lookup(each.value.source.helm, "values", []) :
    yamldecode(templatefile("${var.config_path}/${file}", var.variables))
  ]
}

module "applications" {
  source = "Invicton-Labs/deepmerge/null"
  maps = concat(
    [
      for index, spec in local.applications :
      {
        "applications" : {
          "${spec.metadata.name}" : spec
        }
      }
    ],
    [
      for index, spec in local.applications :
      {
        "applications" : {
          "${spec.metadata.name}" : {
            "source" : {
              "helm" : {
                "releaseName" : spec.metadata.name
                "values" : yamlencode(module.values[index].merged)
              }
            }
          }
        }
      }
    ]
  )
}
