variable "network_name" {
  type        = string
  description = "The network name"
}
variable "vpc_cidr" {
  type        = string
  description = "The VPC CIDR"
}

variable "app_subnets" {
  type        = list(string)
  description = "The app subnets CIDRs"
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets CIDRs"
}

variable "data_subnets" {
  type        = list(string)
  description = "The data subnets CIDRs"
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
