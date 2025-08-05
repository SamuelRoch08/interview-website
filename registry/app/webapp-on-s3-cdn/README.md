# webapp 2

## Description 

Deploy a new webapp on S3.

![Module Architecture](.assets/archi.png)

## Requirement

To manage this module you need 
  - [terraform](https://www.terraform.io)
  - [terraform-docs](https://github.com/terraform-docs/terraform-docs)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.7.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.7.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ../../components/network/cloudfront-s3 | n/a |
| <a name="module_s3_buckets"></a> [s3\_buckets](#module\_s3\_buckets) | ./buckets-and-push | n/a |
| <a name="module_s3_buckets_dr"></a> [s3\_buckets\_dr](#module\_s3\_buckets\_dr) | ./buckets-and-push | n/a |
| <a name="module_s3_replication"></a> [s3\_replication](#module\_s3\_replication) | ../../components/storage/s3-replication | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.build_project](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.synchro_project](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.synchro_project_dr](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_dr"></a> [deploy\_dr](#input\_deploy\_dr) | Deploy DR in secondary region if needed. | `bool` | `false` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | Profile used for authentication to AWS. -- Can be changed or ignored if using a CICD or default profile. | `string` | n/a | yes |
| <a name="input_secondary_region"></a> [secondary\_region](#input\_secondary\_region) | Secondary region to deploy the DR into. | `string` | `"eu-central-1"` | no |
| <a name="input_webapp_name"></a> [webapp\_name](#input\_webapp\_name) | Webapp name to deploy. Will be used for all sub-resources names. | `string` | n/a | yes |
| <a name="input_webapp_src_code"></a> [webapp\_src\_code](#input\_webapp\_src\_code) | Complete path to build code and publish it on ECS cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_url"></a> [app\_url](#output\_app\_url) | n/a |
<!-- END_TF_DOCS -->