variable "cluster_name" {
  type        = string
  description = "Cluster name."
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

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "List of subnets IDs for the cluster servers."
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
