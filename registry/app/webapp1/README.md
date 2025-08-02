# vpc-and-subnets-single-nat

## Description 

Deploy a new webapp.

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

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network_foundations"></a> [network\_foundations](#module\_network\_foundations) | ../../network/vpc-subnets-multi-az | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_subnets"></a> [app\_subnets](#input\_app\_subnets) | The app subnets CIDRs | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_data_subnets"></a> [data\_subnets](#input\_data\_subnets) | The data subnets CIDRs | `list(string)` | <pre>[<br>  "10.0.21.0/24",<br>  "10.0.22.0/24",<br>  "10.0.23.0/24"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets CIDRs | `list(string)` | <pre>[<br>  "10.0.11.0/24",<br>  "10.0.12.0/24",<br>  "10.0.13.0/24"<br>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The VPC CIDR | `string` | `"10.0.0.0/22"` | no |
| <a name="input_webapp_name"></a> [webapp\_name](#input\_webapp\_name) | Webapp name to deploy. Will be used for all sub-resources names. | `string` | n/a | yes |
| <a name="input_wepapp_tags"></a> [wepapp\_tags](#input\_wepapp\_tags) | Web app dedicated tags to add to any resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->