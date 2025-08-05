variable "webapp_name" {
  type        = string
  description = "Webapp name used to define the origin ID."
}

variable "main_bucket_name" {
  type        = string
  description = "Main bucket s3 to cloudfront."
}

variable "main_bucket_id" {
  type        = string
  description = "Bucket main ID."
}
variable "main_bucket_arn" {
  type        = string
  description = "Bucket main ARN."
}

variable "origin_bucket_regional_domain_name" {
  type        = string
  description = "Main bucket s3 to cloudfront with regional DNS."
}
# # # # # # # # # # # # # #
# Optional Log Bucket 
# # # # # # # # # # # # # #
variable "use_log_bucket" {
  type        = bool
  default     = false
  description = "Use log bucket or not."
}

variable "log_bucket_domain_name" {
  type        = string
  description = "Bucket log domain name."
  default     = ""
}

variable "log_bucket_id" {
  type        = string
  description = "Bucket log ID."
  default     = ""
}

variable "log_bucket_arn" {
  type        = string
  description = "Bucket log arn."
  default     = ""
}

# # # # # # # # # # # # # #
# Optional Failover Bucket 
# # # # # # # # # # # # # #
variable "use_failover_bucket" {
  type        = bool
  default     = false
  description = "Use failover bucket or not."
}

variable "failover_bucket_regional_domain_name" {
  type        = string
  description = "Bucket regional name for failover."
  default     = ""
}

variable "failover_bucket_id" {
  type        = string
  description = "Bucket failover ID."
  default     = ""
}

variable "failover_bucket_arn" {
  type        = string
  description = "Bucket failover arn."
  default     = ""
}

# # # # # # # # # # # # # #
# Distribution parameters 
# # # # # # # # # # # # # #
variable "dns_aliases" {
  type        = list(string)
  description = "List of other DNS aliases used to reach the distrib."
  default     = []
}

variable "allowed_methods" {
  type        = list(string)
  description = "Default methods allowed to the origin. Can multiple of DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT"
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  type        = list(string)
  description = "Default methods cached by the distribution. Can multiple of DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT"
  default     = ["GET", "HEAD"]
}

variable "whitelist_locations" {
  type        = list(string)
  description = "List of countries enabled to reach the distribution."
  default     = ["FR", "CH", "US"]
}

variable "root_index_file" {
  type        = string
  description = "Root file as entrypoint for web access."
  default     = "index.html"
}

variable "min_ttl" {
  type        = number
  description = "Minimum TTL allowed for caching objects when explictly asked in the header by the request."
  default     = 0
}
variable "max_ttl" {
  type        = number
  description = "Maximum TTL allowed for caching objects when explictly asked in the header by the request."
  default     = 86400
}
variable "default_ttl" {
  type        = number
  description = "Default TTL for caching objects when not asked in the header by the request."
  default     = 3600
}

variable "extra_tags" {
  type        = map(string)
  description = "Extra tags to add to any resources."
  default     = {}
}
