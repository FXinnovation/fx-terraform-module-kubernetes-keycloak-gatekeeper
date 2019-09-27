variable "deployment_name" {
  description = "Name of the deployment that will be create, if left empty, will default to 'azure-metrics-exporter'"
  default     = "keycloak-gatekeeper"
}

variable "namespace" {
  description = "Namespace in which the module will be deployed."
  default     = "default"
}

variable "annotations" {
  description = "Additionnal annotations that will be merged on all resources."
  default     = {}
}

variable "deployment_annotations" {
  description = "Additionnal annotations that will be merged on the deployment."
  default     = {}
}

variable "labels" {
  description = "Additionnal labels that will be merged on all resources."
  default     = {}
}

variable "deployment_labels" {
  description = "Additionnal labels that will be merged on the deployment."
  default     = {}
}

variable "replicas" {
  description = "Number of replicas to deploy."
  default     = 3
}

variable "image_pull_policy" {
  description = "Image pull policy on the main container."
  default     = "IfNotPresent"
}

variable "service_name" {
  description = "Name of the service that will be create"
  default     = "keycloak-gatekeeper"
}

variable "service_annotations" {
  description = "Additionnal annotations that will be merged for the service."
  default     = {}
}

variable "service_labels" {
  description = "Additionnal labels that will be merged for the service."
  default     = {}
}

variable "port" {
  description = "Port to be used for the service."
  default     = 80
}

variable "config_map_name" {
  description = "Name of the config map that will be created."
  default     = "keycloak-gatekeeper"
}

variable "config_map_annotations" {
  description = "Additionnal annotations that will be merged for the config map."
  default     = {}
}

variable "config_map_labels" {
  description = "Additionnal labels that will be merged for the config map."
  default     = {}
}

variable "ingress_name" {
  description = "Name of the config map that will be created."
  default     = "keycloak-gatekeeper"
}

variable "ingress_annotations" {
  description = "Additionnal annotations that will be merged for the config map."
  default     = {}
}

variable "ingress_labels" {
  description = "Additionnal labels that will be merged for the config map."
  default     = {}
}

variable "ingress_host" {
  description = "Additionnal labels that will be merged for the config map."
  type        = string
}

variable "configuration" {
  description = "Keycloak configuration as a yaml string."
  type        = string
}
