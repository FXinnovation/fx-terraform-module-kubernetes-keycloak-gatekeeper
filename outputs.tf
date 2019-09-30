output "namespace" {
  description = "Namespace in which the module is deployed."
  value       = var.enabled ? var.namespace : ""
}

output "deployment_name" {
  description = "Name of the deployment created by this module."
  value       = var.enabled ? var.deployment_name : ""
}

output "service_name" {
  description = "Name of the service created by this module."
  value       = var.enabled ? var.service_name : ""
}

output "config_map_name" {
  description = "Name of the config_map created by this module."
  value       = var.enabled ? var.config_map_name : ""
}

output "ingress_name" {
  description = "Name of the ingree created by this module."
  value       = var.enabled ? var.ingress_name : ""
}

output "port" {
  description = "Port on which the service listens."
  value       = var.enabled ? var.port : ""
}
