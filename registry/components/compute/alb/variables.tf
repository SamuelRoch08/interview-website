variable "project_name" {
  type        = string
  description = "Project name for resources prefix."
}

variable "is_internal" {
  type        = bool
  description = "Internal ALB ?"
  default     = true
}

variable "lb_subnets" {
  type        = list(string)
  description = "List of subnets to deploy the ALB into."
}

variable "enable_lb_access_logging" {
  type        = bool
  description = "Enable LB access logging."
  default     = false
}

variable "listener_port" {
  type        = number
  description = "Listener port for the AlB."
}

variable "listener_protocol" {
  type        = string
  description = "Listener protocol."
  validation {
    error_message = "listener_protocol must be one of HTTPS or HTTP"
    condition     = contains(["HTTPS", "HTTP"], var.listener_protocol)
  }
  default = "HTTP"
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
