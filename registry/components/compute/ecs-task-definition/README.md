# ecs-task-definition

## Description 

Deploy a new task definition with a single container.


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
| [aws_ecs_task_definition.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.task_exec_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.task_exec_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Container name inside the task def. | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port. | `number` | `80` | no |
| <a name="input_cpu_arch"></a> [cpu\_arch](#input\_cpu\_arch) | Compatible CPU architecture. | `string` | `"X86_64"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to any resources. | `map(string)` | `{}` | no |
| <a name="input_host_port"></a> [host\_port](#input\_host\_port) | Host port. If 0, the port is random so multiple tasks can run on the same host. | `number` | `0` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | Image URI. | `string` | n/a | yes |
| <a name="input_os_family"></a> [os\_family](#input\_os\_family) | Target OS family. | `string` | `"LINUX"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name for resources names. | `string` | n/a | yes |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | Number of CPU units. 256 = 0.25vCPU, 512 = 0.5vCPU etc. | `number` | `512` | no |
| <a name="input_task_mem"></a> [task\_mem](#input\_task\_mem) | Number of Mem in MB. | `number` | `1024` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_def_arn"></a> [task\_def\_arn](#output\_task\_def\_arn) | n/a |
| <a name="output_task_def_name"></a> [task\_def\_name](#output\_task\_def\_name) | n/a |
| <a name="output_task_def_revision"></a> [task\_def\_revision](#output\_task\_def\_revision) | n/a |
<!-- END_TF_DOCS -->