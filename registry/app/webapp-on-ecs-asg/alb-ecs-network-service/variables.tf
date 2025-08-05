variable "webapp_name" {
  type        = string
  description = "Webapp name to deploy. Will be used for all sub-resources names."
}

variable "webapp_src_code" {
  type        = string
  description = "Complete path to build code and publish it on ECS cluster."
}

variable "container_name" {
  type        = string
  description = "Container name that is deployed."
}

variable "container_cpu" {
  type        = number
  description = "Number of CPU units for the container. 256 = 0.25vCPU, 512 = 0.5vCPU etc."
  default     = 512
}

variable "container_mem" {
  type        = number
  description = "Number of Mem in MB for the container."
  default     = 1024
}

variable "container_port" {
  type        = number
  description = "Container name. Default 80."
  default     = 80
}

variable "app_listener_port" {
  type        = number
  description = "Global listener port of the application. Default is 80."
  default     = 80
}

variable "app_listener_protocol" {
  type        = string
  description = "Global listener protocol of the application. Default is HTTP."
  default     = "HTTP"
}


variable "cluster_max_size" {
  type        = number
  description = "Cluster maximum size."
  default     = 3
}

variable "cluster_min_size" {
  type        = number
  description = "Cluster minimum size."
  default     = 1
}

variable "cluster_target_size" {
  type        = number
  description = "Cluster target size."
  default     = 2
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC CIDR"
  default     = "10.0.0.0/19"
}

variable "app_subnets" {
  type        = list(string)
  description = "The app subnets CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets CIDRs"
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "data_subnets" {
  type        = list(string)
  description = "The data subnets CIDRs"
  default     = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
}

variable "wepapp_tags" {
  type        = map(string)
  description = "Web app dedicated tags to add to any resources."
  default     = {}
}
