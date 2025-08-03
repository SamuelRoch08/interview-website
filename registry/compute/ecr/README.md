# ecr

## Description 

Deploy a new ECR repository.


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
| [aws_ecr_lifecycle_policy.ecr_limits](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.app_a_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to any resources. | `map(string)` | `{}` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Delete ECR even if there are images in it. | `bool` | `false` | no |
| <a name="input_max_images_retained"></a> [max\_images\_retained](#input\_max\_images\_retained) | Amount of images to keep in the ECR. | `number` | `4` | no |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | ECR repo name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_id"></a> [ecr\_id](#output\_ecr\_id) | ECR Id. |
| <a name="output_ecr_name"></a> [ecr\_name](#output\_ecr\_name) | ECR name. |
| <a name="output_ecr_url"></a> [ecr\_url](#output\_ecr\_url) | ECR URL. |
<!-- END_TF_DOCS -->