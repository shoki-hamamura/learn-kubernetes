# Terraform configuration
terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Kubernetes provider
provider "kubernetes" {
  # for OrbStack. in prod we should set AWS IAM, ...
  config_path = "~/.kube/config"
}

# create namespace
resource "kubernetes_namespace" "learning" {
  metadata {
    name = "kubernetes-study"
  }
}

# Nginx deployment
resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.learning.metadata[0].name
  }

  spec {
    # prioritize autoscaler
    # replicas = 2

    # identify the target
    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx-container"

          resources {
            # min
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
            # max
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

# Service (NodePort)
resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.learning.metadata[0].name
  }

  spec {
    type = "NodePort"
    selector = {
      app = kubernetes_deployment.nginx.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }
  }
}

# autoscaler
resource "kubernetes_horizontal_pod_autoscaler_v2" "nginx" {
  metadata {
    name      = "nginx-hpa"
    namespace = kubernetes_namespace.learning.metadata[0].name
  }

  spec {
    max_replicas = 5
    min_replicas = 1

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.nginx.metadata[0].name
    }

    # autoscaling criteria
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 10
        }
      }
    }
  }
}
