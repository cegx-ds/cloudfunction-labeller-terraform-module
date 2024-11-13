## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.11.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 6.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_pubsub_topic) | resource |
| [google_cloudfunctions2_function.function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) | resource |
| [google_service_account.function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket_iam_member.function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_available_cpu"></a> [available\_cpu](#input\_available\_cpu) | The amount of CPU available for the Cloud Function. | `number` | `1` | no |
| <a name="input_available_memory"></a> [available\_memory](#input\_available\_memory) | The amount of memory available for the Cloud Function. | `string` | `"256MB"` | no |
| <a name="input_cloud_function_description"></a> [cloud\_function\_description](#input\_cloud\_function\_description) | decription for cloud function | `string` | `"Cloud Function Managed by Terraform"` | no |
| <a name="input_create_pubsub_topic"></a> [create\_pubsub\_topic](#input\_create\_pubsub\_topic) | Whether to create a pubsub topic and attach it to cloud function event trigger | `bool` | n/a | yes |
| <a name="input_entry_point"></a> [entry\_point](#input\_entry\_point) | entry point for cloud function | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | environment name i.e. prod\|dev\|staging | `string` | n/a | yes |
| <a name="input_max_instance_count"></a> [max\_instance\_count](#input\_max\_instance\_count) | The maximum number of instances for the Cloud Function. | `number` | `10` | no |
| <a name="input_min_instance_count"></a> [min\_instance\_count](#input\_min\_instance\_count) | The minimum number of instances for the Cloud Function. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name for all resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | project ID to apply resources to | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | region in which to deploy resource | `string` | `"europe-west2"` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | cloud function runtime | `string` | n/a | yes |
| <a name="input_storage_source_bucket_name"></a> [storage\_source\_bucket\_name](#input\_storage\_source\_bucket\_name) | Name of the bucket that stores source zip file for cloudfunction | `string` | n/a | yes |
| <a name="input_storage_source_object_name"></a> [storage\_source\_object\_name](#input\_storage\_source\_object\_name) | Name of the object that contains source code for cloudfunction | `string` | n/a | yes |
| <a name="input_timeout_seconds"></a> [timeout\_seconds](#input\_timeout\_seconds) | The timeout for the Cloud Function in seconds. | `number` | `120` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pubsub_topic_id"></a> [pubsub\_topic\_id](#output\_pubsub\_topic\_id) | n/a |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | n/a |
| <a name="output_service_account_member"></a> [service\_account\_member](#output\_service\_account\_member) | n/a |
