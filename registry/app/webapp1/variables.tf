variable "webapp_name" {
  type        = string
  description = "Webapp name to deploy. Will be used for all sub-resources names."
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
