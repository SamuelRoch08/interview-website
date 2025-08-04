variable "webapp_name" {
  type        = string
  description = "Webapp name to deploy. Will be used for all sub-resources names."
}

variable "webapp_src_code" {
  type        = string
  description = "Complete path to build code and publish it on ECS cluster."
}

variable "profile" {
  type        = string
  description = "Profile used for authentication to AWS. -- Can be changed or ignored if using a CICD or default profile."
}

variable "dr_region" {
  type = string 
  description = "DR region. If omit or equal to the current region, no DR will be created."
  default = ""
}
