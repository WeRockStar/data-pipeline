<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.31.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.13 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.29.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.31.1 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.13.2 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.bastion-ssh](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/compute_firewall) | resource |
| [google_compute_instance.gke-bastion](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/compute_instance) | resource |
| [google_container_cluster.gke_cluster](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/container_cluster) | resource |
| [google_container_node_pool.gke_node_pool](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/container_node_pool) | resource |
| [google_project_iam_binding.bastion_sa_roles](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.gke_sa](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/project_iam_binding) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/project_service) | resource |
| [google_service_account.bastion](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/service_account) | resource |
| [google_service_account.gke](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/resources/service_account) | resource |
| [helm_release.airbyte](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/data-sources/client_config) | data source |
| [google_container_cluster.gke](https://registry.terraform.io/providers/hashicorp/google/5.31.1/docs/data-sources/container_cluster) | data source |
| [template_file.startup_script](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion-sa-roles"></a> [bastion-sa-roles](#input\_bastion-sa-roles) | n/a | `list(string)` | <pre>[<br>  "roles/iam.serviceAccountUser"<br>]</pre> | no |
| <a name="input_bastion_hostname"></a> [bastion\_hostname](#input\_bastion\_hostname) | n/a | `string` | `"gke-bastion"` | no |
| <a name="input_bastion_machine_type"></a> [bastion\_machine\_type](#input\_bastion\_machine\_type) | The instance size to use for your bastion instance. | `string` | `"g1-small"` | no |
| <a name="input_bastion_tags"></a> [bastion\_tags](#input\_bastion\_tags) | A list of tags applied to your bastion instance. | `list(string)` | <pre>[<br>  "bastion"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"asia-southeast1-a"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of GKE nodes | `number` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Porject | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_sa-roles"></a> [sa-roles](#input\_sa-roles) | n/a | `list(string)` | <pre>[<br>  "roles/logging.admin",<br>  "roles/monitoring.admin",<br>  "roles/cloudtrace.admin",<br>  "roles/servicemanagement.serviceController",<br>  "roles/artifactregistry.reader",<br>  "roles/compute.securityAdmin",<br>  "roles/compute.networkUser"<br>]</pre> | no |
| <a name="input_services"></a> [services](#input\_services) | List of GCP services to enable | `list(string)` | <pre>[<br>  "compute.googleapis.com",<br>  "iam.googleapis.com",<br>  "container.googleapis.com",<br>  "iap.googleapis.com"<br>]</pre> | no |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | n/a | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | n/a | yes |
| <a name="input_zone_c"></a> [zone\_c](#input\_zone\_c) | n/a | `string` | `"asia-southeast1-c"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
