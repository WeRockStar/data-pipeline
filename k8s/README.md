# Kubernetes

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## How to Provision

### Step 1: Apply Ingress

```bash
kubectl apply -f ingress.yaml
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.37.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.40.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.31.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.37.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 5.40.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.airbyte_a_record](https://registry.terraform.io/providers/cloudflare/cloudflare/4.37.0/docs/resources/record) | resource |
| [cloudflare_record.airflow_a_record](https://registry.terraform.io/providers/cloudflare/cloudflare/4.37.0/docs/resources/record) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/5.40.0/docs/data-sources/client_config) | data source |
| [google_container_cluster.gke](https://registry.terraform.io/providers/hashicorp/google/5.40.0/docs/data-sources/container_cluster) | data source |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.31.0/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | n/a | `string` | n/a | yes |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | GKE Cluster Endpoint | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | `"data-pipeline-cluster"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"asia-southeast1-a"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | `"learn-airbyte-425016"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Porject | `string` | `"data-pipeline"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"asia-southeast1"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Cloudflare Zone ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->