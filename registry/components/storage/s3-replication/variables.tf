variable "project_prefix" {
  type = string 
  description = "prefix used for all resources naming."
}

variable "source_bucket_name" {
  type = string 
  description = "Source bucket name."
}

variable "source_bucket_arn" {
  type = string 
  description = "Source bucket ARN."
}

variable "destination_bucket_name" {
  type = string 
  description = "Destination bucket name."
}

variable "destination_bucket_arn" {
  type = string 
  description = "Destination bucket ARN."
}