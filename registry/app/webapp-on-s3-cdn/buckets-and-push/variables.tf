variable "prefix_buckets_name" {
  type        = string
  description = "Prefix of buckets to use to create buckets names."
}

variable "webapp_src_code" {
  type        = string
  description = "Complete path to build code and publish it on ECS cluster."
}

variable "profile" {
  type        = string
  description = "Profile used for authentication to AWS. -- Can be changed or ignored if using a CICD or default profile."
}