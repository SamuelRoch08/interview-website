# cloudfront-s3

## Description 

Deploy a new Cloudfront distribution


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
| <a name="provider_aws.failover"></a> [aws.failover](#provider\_aws.failover) | >= 6.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.oac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_s3_bucket_policy.allow_cloudfront_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.allow_cloudfront_access_failover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.s3_cloudfront_logs_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_bucket.log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_s3_bucket.origin_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | Default methods allowed to the origin. Can multiple of DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT | `list(string)` | <pre>[<br>  "DELETE",<br>  "GET",<br>  "HEAD",<br>  "OPTIONS",<br>  "PATCH",<br>  "POST",<br>  "PUT"<br>]</pre> | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | Default methods cached by the distribution. Can multiple of DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | Default TTL for caching objects when not asked in the header by the request. | `number` | `3600` | no |
| <a name="input_dns_aliases"></a> [dns\_aliases](#input\_dns\_aliases) | List of other DNS aliases used to reach the distrib. | `list(string)` | `[]` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to any resources. | `map(string)` | `{}` | no |
| <a name="input_failover_bucket_arn"></a> [failover\_bucket\_arn](#input\_failover\_bucket\_arn) | Bucket failover arn. | `string` | `""` | no |
| <a name="input_failover_bucket_id"></a> [failover\_bucket\_id](#input\_failover\_bucket\_id) | Bucket failover name. | `string` | `""` | no |
| <a name="input_failover_bucket_regional_domain_name"></a> [failover\_bucket\_regional\_domain\_name](#input\_failover\_bucket\_regional\_domain\_name) | Bucket regional name for failover. | `string` | `""` | no |
| <a name="input_log_bucket_name"></a> [log\_bucket\_name](#input\_log\_bucket\_name) | S3 bucket where to stream logs into. | `string` | `""` | no |
| <a name="input_main_bucket_name"></a> [main\_bucket\_name](#input\_main\_bucket\_name) | Main bucket s3 to cloudfront. | `string` | n/a | yes |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Maximum TTL allowed for caching objects when explictly asked in the header by the request. | `number` | `86400` | no |
| <a name="input_min_ttl"></a> [min\_ttl](#input\_min\_ttl) | Minimum TTL allowed for caching objects when explictly asked in the header by the request. | `number` | `0` | no |
| <a name="input_root_index_file"></a> [root\_index\_file](#input\_root\_index\_file) | Root file as entrypoint for web access. | `string` | `"index.html"` | no |
| <a name="input_use_failover_bucket"></a> [use\_failover\_bucket](#input\_use\_failover\_bucket) | Use failover bucket or not. | `bool` | `false` | no |
| <a name="input_use_log_bucket"></a> [use\_log\_bucket](#input\_use\_log\_bucket) | Use logging bucket or not. | `bool` | `false` | no |
| <a name="input_webapp_name"></a> [webapp\_name](#input\_webapp\_name) | Webapp name used to define the origin ID. | `string` | n/a | yes |
| <a name="input_whitelist_locations"></a> [whitelist\_locations](#input\_whitelist\_locations) | List of countries enabled to reach the distribution. | `list(string)` | <pre>[<br>  "FR",<br>  "CH",<br>  "US"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | Distribution ARN |
| <a name="output_distribution_dns"></a> [distribution\_dns](#output\_distribution\_dns) | Distribution DNS |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | Distribution ID |
<!-- END_TF_DOCS -->