# ecs-on-asg

## Description 

Deploy a new ECS cluster based on ASG.


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
| [aws_autoscaling_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_log_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_capacity_provider.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_iam_instance_profile.ec2_role_for_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2_role_for_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_for_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_for_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.inbound_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.outbound_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.ecs_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.app_a_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_inbound_cidr"></a> [allowed\_inbound\_cidr](#input\_allowed\_inbound\_cidr) | Allowed inbound CIDRs that can access the nodes. | `list(string)` | n/a | yes |
| <a name="input_cluster_instance_ami"></a> [cluster\_instance\_ami](#input\_cluster\_instance\_ami) | Target AMI for instances. | `string` | `"ami-08c9a28b806bde705"` | no |
| <a name="input_cluster_instance_types"></a> [cluster\_instance\_types](#input\_cluster\_instance\_types) | Target instances types. | `string` | `"t3.micro"` | no |
| <a name="input_cluster_max_size"></a> [cluster\_max\_size](#input\_cluster\_max\_size) | Cluster maximum size. | `number` | `3` | no |
| <a name="input_cluster_min_size"></a> [cluster\_min\_size](#input\_cluster\_min\_size) | Cluster minimum size. | `number` | `1` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name. | `string` | n/a | yes |
| <a name="input_cluster_subnet_ids"></a> [cluster\_subnet\_ids](#input\_cluster\_subnet\_ids) | List of subnets IDs for the cluster servers. | `list(string)` | n/a | yes |
| <a name="input_cluster_target_size"></a> [cluster\_target\_size](#input\_cluster\_target\_size) | Cluster target size. | `number` | `2` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to any resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_arn"></a> [ecs\_arn](#output\_ecs\_arn) | n/a |
| <a name="output_ecs_capacity_provider_arn"></a> [ecs\_capacity\_provider\_arn](#output\_ecs\_capacity\_provider\_arn) | n/a |
<!-- END_TF_DOCS -->