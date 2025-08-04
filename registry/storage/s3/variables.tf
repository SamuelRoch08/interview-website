##### BUCKET #####

variable "bucket_name" {
  description = "The Bucket name"
  type        = string
}

variable "force_destroy" {
  type        = bool
  description = "Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed."
  default     = false
}

variable "bucket_versioning" {
  description = "Add versioning on the bucket or not"
  type        = string
  default     = "Disabled"
  validation {
    condition     = contains(["Enabled", "Disabled", "Suspended"], var.bucket_versioning)
    error_message = "Bucket versioning must be Enabled or Disabled or Suspended."
  }
}

# SSE Block
variable "sse_config" {
  description = "Configures server side encryption for the bucket.  The sse_key should either be set to S3 or a KMS Key ID"
  type = list(object({
    sse_key            = string
    bucket_key_enabled = bool
  }))
  default = []
}

# Lifecycle Rules
variable "lifecycle_rule" {
  description = "A data structure to create lifecycle rules"
  type = list(object({
    id                                     = string
    prefix                                 = string
    enabled                                = bool
    abort_incomplete_multipart_upload_days = number
    expiration_config = list(object({
      days                         = number
      expired_object_delete_marker = bool
    }))
    noncurrent_version_expiration_config = list(object({
      days = number
    }))
    transitions_config = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_transitions_config = list(object({
      days          = number
      storage_class = string
    }))
  }))
  default = []
}

variable "bucket_lifecycle_transitions" {
  description = "Transition days and storage class"
  type = list(object({
    days          = number
    storage_class = string
  }))
  default = [{ "days" = 0, "storage_class" = "PLEASE DEFINE ME" }]
}

# Bucket Policy
variable "bucket_policy" {
  type        = string
  description = "The policy of the bucket"
  default     = ""
}

# S3 Bucket Ownership Controls (Enable or Disable ACLs)
variable "bucket_ownership_controls" {
  description = "The Bucket Ownership Controls"
  type        = string
  default     = "BucketOwnerEnforced"
  validation {
    condition     = contains(["BucketOwnerPreferred", "ObjectWriter", "BucketOwnerEnforced"], var.bucket_ownership_controls)
    error_message = "Bucket Ownership Controls must be BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced (Disable ACLs)."
  }
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}