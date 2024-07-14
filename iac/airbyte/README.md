<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.34.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.37.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.29.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.34.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 5.37.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.29.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.airbyte_record](https://registry.terraform.io/providers/cloudflare/cloudflare/4.34.0/docs/resources/record) | resource |
| [kubernetes_namespace.airbyte](https://registry.terraform.io/providers/hashicorp/kubernetes/2.29.0/docs/resources/namespace) | resource |
| [null_resource.execute_command](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/data-sources/client_config) | data source |
| [google_container_cluster.gke](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/data-sources/container_cluster) | data source |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/2.29.0/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | Cloudflare API Token | `string` | n/a | yes |
| <a name="input_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#input\_cluster\_ca\_certificate) | GKE Cluster CA Certificate | `string` | n/a | yes |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | GKE Cluster Endpoint | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Cloudflare Zone ID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
