variable "crds_version" {
  description = "Version of the VictoriaMetrics Operator release, e.g. 0.44.0"
  type        = string

  validation {
    condition = tonumber(
      "${element(split(".", var.crds_version), 0)}.${element(split(".", var.crds_version), 1)}"
    ) >= 0.31
    error_message = "Only VictoriaMetrics Operator versions >= 0.31.0 are supported."
  }
}

variable "crd_dl_url" {
  description = "Template string of the URL to download CRDs"
  type        = string
  default     = "https://github.com/VictoriaMetrics/operator/releases/download/v%s/crd.yaml"

}

variable "crds_list" {
  description = "List of CRDs to deploy. If not set, all CRDs will be deployed."
  type        = set(string)
  default     = []
}

variable "force_override_conflicts" {
  description = "Force override fields manager conflicts. May be useful when importing existing CRDs."
  type        = bool
  default     = false
}
