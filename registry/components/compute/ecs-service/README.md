# ecs-service

## Description 

Deploy a a new service on an ECS cluster. Based on a task definition.
Optionaly link to an ALB.


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
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_max_per"></a> [deploy\_max\_per](#input\_deploy\_max\_per) | Percentage Max that the services must be available for the a deployment update. | `number` | `200` | no |
| <a name="input_deploy_min_per"></a> [deploy\_min\_per](#input\_deploy\_min\_per) | Percentage Min that the services must be available for the a deployment update. | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Amount of task def instanciated. | `number` | `3` | no |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | ECS Cluster ARN to deploy the service onto. | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to any resources. | `map(string)` | `{}` | no |
| <a name="input_force_deploy"></a> [force\_deploy](#input\_force\_deploy) | Force redeployment of service. | `bool` | `false` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type. Either EC2, FARGATE, or EXTERNAL. | `string` | `"EC2"` | no |
| <a name="input_lb_container_name"></a> [lb\_container\_name](#input\_lb\_container\_name) | Name of the container to associate with the load balancer (as it appears in a container definition). | `string` | `""` | no |
| <a name="input_lb_container_port"></a> [lb\_container\_port](#input\_lb\_container\_port) | Port on the container to associate with the load balancer. | `string` | `""` | no |
| <a name="input_lb_target_group_arn"></a> [lb\_target\_group\_arn](#input\_lb\_target\_group\_arn) | Target Group ARN to link to the service if we need LB management. | `string` | `""` | no |
| <a name="input_placement_strategy"></a> [placement\_strategy](#input\_placement\_strategy) | Strategy to place the taks on the nodes. | `string` | `"spread"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name for resources names. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name. | `string` | n/a | yes |
| <a name="input_task_arn_role"></a> [task\_arn\_role](#input\_task\_arn\_role) | Role ARN to attach to the task deployments to allow containers API calls to AWS. | `string` | `""` | no |
| <a name="input_task_def_arn"></a> [task\_def\_arn](#input\_task\_def\_arn) | Task definition ARN reference. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->