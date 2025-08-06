variable "webapp_name" {
  type        = string
  description = "Webapp name used to define the origin ID."
}

variable "main_dns" {
  type        = string
  description = "Main DNS to cloudfront."
}

variable "main_alb_arn" {
  type        = string
  description = "Main ALB arn to create the VPC origin. "
}

variable "main_alb_config" {
  type = object({
    http_port       = number
    https_port      = number
    protocol_policy = string
    ssl_protocols   = list(string)
  })
  description = "Config of ALB origin. Protocol policy must be http-only, https-only, match-viewer."
}

variable "use_failover_dns" {
  type        = bool
  default     = false
  description = "Use failover DNS or not."
}

variable "failover_alb_arn" {
  type        = string
  description = "Failover ALB arn to create the VPC origin. "
  default     = ""
}

variable "failover_alb_config" {
  type = object({
    http_port       = number
    https_port      = number
    protocol_policy = string
    ssl_protocols   = list(string)
  })
  description = "Config of ALB origin as failover. Protocol policy must be http-only, https-only, match-viewer."
  default = {
    http_port       = 0
    https_port      = 0
    protocol_policy = ""
    ssl_protocols   = [""]
  }
}

variable "failover_dns" {
  type        = string
  description = "DNS for failover."
  default     = ""
}

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
