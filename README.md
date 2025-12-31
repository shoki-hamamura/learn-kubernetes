# learn-kubernetes

[![CI](https://github.com/shoki-hamamura/learn-kubernetes/actions/workflows/ci.yml/badge.svg)](https://github.com/shoki-hamamura/learn-kubernetes/actions/workflows/ci.yml)

Kubernetes + Terraform learning repository.

## Setup

```bash
mise install
mise run setup
```

## Tasks

```bash
mise run lint      # Run tflint
mise run fmt       # Format Terraform files
mise run plan      # Run terraform plan
mise run apply     # Run terraform apply
mise run docs      # Generate terraform docs
mise run k9s       # Open k9s
```

## Terraform Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment_v1.nginx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment_v1) | resource |
| [kubernetes_horizontal_pod_autoscaler_v2.nginx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler_v2) | resource |
| [kubernetes_namespace_v1.learning](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_service_v1.nginx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_v1) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
