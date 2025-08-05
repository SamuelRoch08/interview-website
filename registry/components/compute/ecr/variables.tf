variable "repo_name" {
  type        = string
  description = "ECR repo name."
}

variable "force_delete" {
  type        = bool
  description = "Delete ECR even if there are images in it."
  default     = false
}

variable "max_images_retained" {
  type        = number
  description = "Amount of images to keep in the ECR."
  default     = 4
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
