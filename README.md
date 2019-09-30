# terraform-module-kubernetes-keycloak-gatekeeper

Terraform module to deploy keycloak-gatekeeper on kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| annotations | Additionnal annotations that will be merged on all resources. | map | `{}` | no |
| config\_map\_annotations | Additionnal annotations that will be merged for the config map. | map | `{}` | no |
| config\_map\_labels | Additionnal labels that will be merged for the config map. | map | `{}` | no |
| config\_map\_name | Name of the config map that will be created. | string | `"keycloak-gatekeeper"` | no |
| configuration | Keycloak configuration as a yaml string. | string | n/a | yes |
| deployment\_annotations | Additionnal annotations that will be merged on the deployment. | map | `{}` | no |
| deployment\_labels | Additionnal labels that will be merged on the deployment. | map | `{}` | no |
| deployment\_name | Name of the deployment that will be create, if left empty, will default to 'azure-metrics-exporter' | string | `"keycloak-gatekeeper"` | no |
| enabled | Whether or not to enable this module. | string | `"true"` | no |
| image\_pull\_policy | Image pull policy on the main container. | string | `"IfNotPresent"` | no |
| ingress\_annotations | Additionnal annotations that will be merged for the config map. | map | `{}` | no |
| ingress\_host | Additionnal labels that will be merged for the config map. | string | n/a | yes |
| ingress\_labels | Additionnal labels that will be merged for the config map. | map | `{}` | no |
| ingress\_name | Name of the config map that will be created. | string | `"keycloak-gatekeeper"` | no |
| labels | Additionnal labels that will be merged on all resources. | map | `{}` | no |
| namespace | Namespace in which the module will be deployed. | string | `"default"` | no |
| port | Port to be used for the service. | string | `"80"` | no |
| replicas | Number of replicas to deploy. | string | `"3"` | no |
| service\_annotations | Additionnal annotations that will be merged for the service. | map | `{}` | no |
| service\_labels | Additionnal labels that will be merged for the service. | map | `{}` | no |
| service\_name | Name of the service that will be create | string | `"keycloak-gatekeeper"` | no |

## Outputs

| Name | Description |
|------|-------------|
| config\_map\_name | Name of the config_map created by this module. |
| deployment\_name | Name of the deployment created by this module. |
| ingress\_name | Name of the ingree created by this module. |
| namespace | Namespace in which the module is deployed. |
| port | Port on which the service listens. |
| service\_name | Name of the service created by this module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
