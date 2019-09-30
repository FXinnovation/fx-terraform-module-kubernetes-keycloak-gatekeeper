#####
# Locals
#####

locals {
  labels = {
    "app.kubernetes.io/name"       = "keycloak-gatekeeper"
    "app.kubernetes.io/instance"   = var.deployment_name
    "app.kubernetes.io/version"    = "0.6.0"
    "app.kubernetes.io/component"  = "auth-proxy"
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  number  = false
  length  = 8
}

#####
# Deployment
#####

resource "kubernetes_deployment" "this" {
  metadata {
    name      = var.deployment_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.deployment_annotations
    )
    labels = merge(
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = random_string.selector.result
      }
    }
    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_annotations
        )
        labels = merge(
          {
            app = random_string.selector.result
          },
          local.labels,
          var.labels,
          var.deployment_labels
        )
      }
      spec {

        volume {
          name = "configuration"
          config_map {
            name = kubernetes_config_map.this.metadata.0.name
            items {
              key  = "gatekeeper.yaml"
              path = "gatekeeper.yaml"
            }
          }
        }

        container {
          name              = "keycloak-gatekeeper"
          image             = "fxinnovation/keycloak-gatekeeper:1.0.0"
          image_pull_policy = var.image_pull_policy

          volume_mount {
            name       = "configuration"
            mount_path = "/opt/keycloak/gatekeeper/conf.d"
          }

          port {
            name           = "http"
            container_port = 3000
            protocol       = "TCP"
          }

          resources {
            requests {
              memory = "32Mi"
              cpu    = "10m"
            }
            limits {
              memory = "128Mi"
              cpu    = "100m"
            }
          }

          liveness_probe {
            tcp_socket {
              port = "http"
            }

            initial_delay_seconds = 10
            period_seconds        = 5
          }

          readiness_probe {
            tcp_socket {
              port = "http"
            }

            initial_delay_seconds = 10
            period_seconds        = 5
          }
        }
      }
    }
  }
}

#####
# Configmap
#####

resource "kubernetes_config_map" "this" {
  metadata {
    name      = var.config_map_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.config_map_annotations
    )
    labels = merge(
      local.labels,
      var.labels,
      var.config_map_labels
    )
  }

  data = {
    "gatekeeper.yaml" = var.configuration
  }
}

#####
# Service
#####

resource "kubernetes_service" "this" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      app = random_string.selector.result
    }
    type = "ClusterIP"
    port {
      port        = 80
      target_port = "http"
      protocol    = "TCP"
      name        = "http"
    }
  }
}

#####
# Ingress
#####

resource "kubernetes_ingress" "this" {
  metadata {
    name      = var.ingress_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.ingress_annotations
    )
    labels = merge(
      local.labels,
      var.labels,
      var.ingress_labels
    )
  }

  spec {
    backend {
      service_name = kubernetes_service.this.metadata.0.name
      service_port = "http"
    }

    rule {
      host = var.ingress_host
      http {
        path {
          backend {
            service_name = kubernetes_service.this.metadata.0.name
            service_port = "http"
          }
          path = "/"
        }
      }
    }

    tls {
      secret_name = "${var.ingress_name}-tls"
      hosts       = [var.ingress_host]
    }
  }
}
