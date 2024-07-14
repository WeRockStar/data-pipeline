<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.37.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.29.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.31.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.vpc_subnetwork](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/compute_subnetwork) | resource |
| [google_container_cluster.gke_cluster](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/container_cluster) | resource |
| [google_container_node_pool.gke_node_pool](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/container_node_pool) | resource |
| [google_project_iam_binding.gke_sa](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/project_iam_binding) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/project_service) | resource |
| [google_service_account.gke](https://registry.terraform.io/providers/hashicorp/google/5.37.0/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_hostname"></a> [bastion\_hostname](#input\_bastion\_hostname) | n/a | `string` | `"gke-bastion"` | no |
| <a name="input_bastion_machine_type"></a> [bastion\_machine\_type](#input\_bastion\_machine\_type) | The instance size to use for your bastion instance. | `string` | `"g1-small"` | no |
| <a name="input_bastion_tags"></a> [bastion\_tags](#input\_bastion\_tags) | A list of tags applied to your bastion instance. | `list(string)` | <pre>[<br>  "bastion"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | GKE Cluster Name | `string` | n/a | yes |
| <a name="input_ip_range"></a> [ip\_range](#input\_ip\_range) | The CIDR range for the VPC. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The IP range for the master node. | `string` | `"10.0.90.0/28"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of GKE nodes | `number` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of Porject | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_sa-roles"></a> [sa-roles](#input\_sa-roles) | n/a | `list(string)` | <pre>[<br>  "roles/logging.admin",<br>  "roles/monitoring.admin",<br>  "roles/cloudtrace.admin",<br>  "roles/servicemanagement.serviceController",<br>  "roles/artifactregistry.reader",<br>  "roles/compute.networkUser"<br>]</pre> | no |
| <a name="input_secondary_ip_range"></a> [secondary\_ip\_range](#input\_secondary\_ip\_range) | The CIDR from which to allocate pod IPs for IP Aliasing. | `string` | `"10.0.92.0/22"` | no |
| <a name="input_services"></a> [services](#input\_services) | List of GCP services to enable | `list(string)` | <pre>[<br>  "compute.googleapis.com",<br>  "iam.googleapis.com",<br>  "container.googleapis.com",<br>  "iap.googleapis.com"<br>]</pre> | no |
| <a name="input_zone_c"></a> [zone\_c](#input\_zone\_c) | n/a | `string` | `"asia-southeast1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_kubernetes_cluster_host"></a> [kubernetes\_cluster\_host](#output\_kubernetes\_cluster\_host) | GKE Cluster Host |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | GKE Cluster Name |
<!-- END_TF_DOCS -->
