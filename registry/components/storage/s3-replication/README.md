# s3-replication

## Description 

Setup a replication between 2 buckets. 

## Requirement

To manage this module you need 
  - [terraform](https://www.terraform.io)
  - [terraform-docs](https://github.com/terraform-docs/terraform-docs)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket_replication_configuration.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_bucket_arn"></a> [destination\_bucket\_arn](#input\_destination\_bucket\_arn) | Destination bucket ARN. | `string` | n/a | yes |
| <a name="input_destination_bucket_name"></a> [destination\_bucket\_name](#input\_destination\_bucket\_name) | Destination bucket name. | `string` | n/a | yes |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | prefix used for all resources naming. | `string` | n/a | yes |
| <a name="input_source_bucket_arn"></a> [source\_bucket\_arn](#input\_source\_bucket\_arn) | Source bucket ARN. | `string` | n/a | yes |
| <a name="input_source_bucket_name"></a> [source\_bucket\_name](#input\_source\_bucket\_name) | Source bucket name. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->