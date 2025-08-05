variable "project_name" {
  type        = string
  description = "Project name for resources names."
}

variable "service_name" {
  type        = string
  description = "Service name."
}

variable "ecs_cluster_arn" {
  type        = string
  description = "ECS Cluster ARN to deploy the service onto."
}

variable "task_def_arn" {
  type        = string
  description = "Task definition ARN reference."
}

variable "lb_target_group_arn" {
  type        = string
  description = "Target Group ARN to link to the service if we need LB management."
  default     = ""
}

variable "lb_container_name" {
  type        = string
  description = "Name of the container to associate with the load balancer (as it appears in a container definition)."
  default     = ""
}

variable "lb_container_port" {
  type        = string
  description = "Port on the container to associate with the load balancer."
  default     = ""
}

variable "desired_count" {
  type        = number
  description = "Amount of task def instanciated."
  default     = 3
}

variable "task_arn_role" {
  type        = string
  description = "Role ARN to attach to the task deployments to allow containers API calls to AWS."
  default     = ""
}

variable "launch_type" {
  type        = string
  description = "Launch type. Either EC2, FARGATE, or EXTERNAL."
  default     = "EC2"
}

variable "deploy_min_per" {
  type        = number
  description = "Percentage Min that the services must be available for the a deployment update."
  default     = 100
}

variable "deploy_max_per" {
  type        = number
  description = "Percentage Max that the services must be available for the a deployment update."
  default     = 200
}

variable "placement_strategy" {
  type        = string
  description = "Strategy to place the taks on the nodes."
  default     = "spread"
  validation {
    error_message = "placement_strategy must be one of binpack, random, or spread."
    condition     = contains(["binpack", "random", "spread"], var.placement_strategy)
  }
}

variable "force_deploy" {
  type        = bool
  description = "Force redeployment of service."
  default     = false
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
