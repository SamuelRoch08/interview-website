variable "primary_region" {
  type        = string
  description = "AWS primary region to use."
}

variable "secondary_region" {
  type        = string
  description = "AWS secondary region to use."
}

variable "webapp1_config" {
  type        = map(any)
  description = "Config for webapp1"
}

variable "webapp2_config" {
  type        = map(any)
  description = "Config for webapp2"
}

variable "profile" {
  type        = string
  default     = "sandbox"
  description = "Profile used for authentication to AWS. -- Can be changed or ignored if using a CICD or default profile."
}
