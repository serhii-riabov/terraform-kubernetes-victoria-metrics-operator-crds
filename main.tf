locals {
  # Splitting individual CRD form single file
  manifests_yaml = {
    for i in split("---\n", data.http.crds_manifest.response_body) :
    regex("  name: (.*).operator.victoriametrics.com\n", i)[0] => yamldecode(i)
  }
  # Generating list of CRDs to deploy
  crds_to_deploy = length(var.crds_list) == 0 ? [for k, v in local.manifests_yaml : k] : var.crds_list
}

# Downloading manifests
data "http" "crds_manifest" {
  url = format(var.crd_dl_url, var.crds_version)
  retry {
    attempts = 2
  }
}

# Creating CRDs
resource "kubernetes_manifest" "crd" {
  for_each = local.crds_to_deploy

  manifest = local.manifests_yaml[each.value]
  field_manager {
    force_conflicts = var.force_override_conflicts
  }
}
