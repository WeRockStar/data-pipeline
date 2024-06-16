<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.31.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.31.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.tf-bucket](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | `"data-pipeline-cluster"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Porject | `string` | `"data-pipeline"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"asia-southeast1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_bucket"></a> [backend\_bucket](#output\_backend\_bucket) | n/a |
<!-- END_TF_DOCS -->
