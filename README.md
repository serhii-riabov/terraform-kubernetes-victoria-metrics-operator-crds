# VictoriaMetrics Operator CRDs Terraform module
Terraform module which creates [VictoriaMetrics Operator](https://github.com/VictoriaMetrics/operator) CRDs in Kubernetes cluster

## Usage
### Basic
```hcl
module "victoriametrics_operator_crds" {
  source  = "serhii-riabov/victoria-metrics-operator-crds/kubernetes"

  crds_version = "0.44.0"
}
```

### Advanced
```hcl
module "victoriametrics_operator_crds" {
  source  = "serhii-riabov/victoria-metrics-operator-crds/kubernetes"

  # Version of CRDs to deploy
  crds_version = "0.44.0"

  # Alternative URL to get source manifests from.
  # %s will be replaced with CRDs version.
  # Example: https://www.example.com/v0.40.0/crd.yaml
  crd_dl_url = "https://www.example.com/v%s/crd.yaml"

  # Deploy only CRDs from the supplied list
  crds_list = [
    "vmagents",
    "vmalertmanagerconfigs",
    "vmalertmanagers",
    "vmalerts",
    "vmauths",
    "vmclusters",
    "vmnodescrapes",
    "vmpodscrapes",
    "vmprobes",
    "vmrules",
    "vmservicescrapes",
    "vmsingles",
    "vmstaticscrapes",
    "vmusers"
  ]

  # Force override fields manager conflicts. May be useful when importing existing CRDs.
  force_override_conflicts = true
}
```
## Importing existing CRDs
It is possible to bring existing VictoriaMetrics Operator CRDs under Terraform management to avoid resource recreation. Before proceeding with the import, make sure you are using matching versions of CRDs. Starting with Terraform v1.5.0 and later it is possible to do this in a declarative way. Below is the code example.  
Setting the `force_override_conflicts` variable to `true` will allow overriding conflicts if CRDs were deployed outside of Terraform in the first place.  

```hcl
# Version >= v0.31.0
import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmagents"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmagents.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmalertmanagerconfigs"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmalertmanagerconfigs.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmalertmanagers"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmalertmanagers.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmalerts"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmalerts.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmauths"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmauths.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmclusters"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmclusters.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmnodescrapes"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmnodescrapes.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmpodscrapes"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmpodscrapes.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmprobes"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmprobes.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmrules"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmrules.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmservicescrapes"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmservicescrapes.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmsingles"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmsingles.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmstaticscrapes"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmstaticscrapes.operator.victoriametrics.com"
}

import {
  to = module.victoria-metrics-operator-crds.kubernetes_manifest.crd["vmusers"]
  id = "apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=vmusers.operator.victoriametrics.com"
}
```

## Notes
Kubernetes >=1.17.0
VictoriaMetrics Operator >= 0.31.0

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.crd](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [http_http.crds_manifest](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_crd_dl_url"></a> [crd\_dl\_url](#input\_crd\_dl\_url) | Template string of the URL to download CRDs | `string` | `"https://github.com/VictoriaMetrics/operator/releases/download/v%s/crd.yaml"` | no |
| <a name="input_crds_list"></a> [crds\_list](#input\_crds\_list) | List of CRDs to deploy. If not set, all CRDs will be deployed. | `set(string)` | `[]` | no |
| <a name="input_crds_version"></a> [crds\_version](#input\_crds\_version) | Version of the VictoriaMetrics Operator release, e.g. 0.40.0 | `string` | n/a | yes |
| <a name="input_force_override_conflicts"></a> [force\_override\_conflicts](#input\_force\_override\_conflicts) | Force override fields manager conflicts. May be useful when importing existing CRDs. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
