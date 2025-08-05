# s3

## Description 

Deploy a new S3 bucket


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
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_lifecycle_transitions"></a> [bucket\_lifecycle\_transitions](#input\_bucket\_lifecycle\_transitions) | Transition days and storage class | <pre>list(object({<br>    days          = number<br>    storage_class = string<br>  }))</pre> | <pre>[<br>  {<br>    "days": 0,<br>    "storage_class": "PLEASE DEFINE ME"<br>  }<br>]</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The Bucket name | `string` | n/a | yes |
| <a name="input_bucket_ownership_controls"></a> [bucket\_ownership\_controls](#input\_bucket\_ownership\_controls) | The Bucket Ownership Controls | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | The policy of the bucket | `string` | `""` | no |
| <a name="input_bucket_versioning"></a> [bucket\_versioning](#input\_bucket\_versioning) | Add versioning on the bucket or not | `string` | `"Disabled"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to any resources. | `map(string)` | `{}` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed. | `bool` | `false` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | A data structure to create lifecycle rules | <pre>list(object({<br>    id                                     = string<br>    prefix                                 = string<br>    enabled                                = bool<br>    abort_incomplete_multipart_upload_days = number<br>    expiration_config = list(object({<br>      days                         = number<br>      expired_object_delete_marker = bool<br>    }))<br>    noncurrent_version_expiration_config = list(object({<br>      days = number<br>    }))<br>    transitions_config = list(object({<br>      days          = number<br>      storage_class = string<br>    }))<br>    noncurrent_version_transitions_config = list(object({<br>      days          = number<br>      storage_class = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_sse_config"></a> [sse\_config](#input\_sse\_config) | Configures server side encryption for the bucket.  The sse\_key should either be set to S3 or a KMS Key ID | <pre>list(object({<br>    sse_key            = string<br>    bucket_key_enabled = bool<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the bucket. Will be of format arn:aws:s3:::bucketname |
| <a name="output_bucket_dns"></a> [bucket\_dns](#output\_bucket\_dns) | Bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Name of the bucket |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The bucket name. |
| <a name="output_bucket_regional_dns"></a> [bucket\_regional\_dns](#output\_bucket\_regional\_dns) | The bucket region-specific domain name. The bucket domain name including the region name |
<!-- END_TF_DOCS -->