resource "aws_cloudfront_distribution" "distribution" {

  dynamic "origin_group" {
    for_each = var.use_failover_dns ? [0] : []

    content {
      origin_id = "${var.webapp_name}-glob"
      failover_criteria {
        status_codes = [403, 404, 500, 502]
      }

      member {
        origin_id = "${var.webapp_name}-prim"
      }

      member {
        origin_id = "${var.webapp_name}-failover"
      }
    }
  }

  origin {
    domain_name = var.main_dns
    origin_id   = "${var.webapp_name}-prim"
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1.2"]
      origin_protocol_policy = "http-only"
    }
  }

  dynamic "origin" {
    for_each = var.use_failover_dns ? [0] : []
    content {
      domain_name = var.failover_dns
      origin_id   = "${var.webapp_name}-failover"
      custom_origin_config {
        http_port              = "80"
        https_port             = "443"
        origin_ssl_protocols   = ["TLSv1.2"]
        origin_protocol_policy = "http-only"
      }
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.root_index_file
  aliases             = var.dns_aliases
  price_class         = "PriceClass_200" # Use North America, Europe, Asia, Middle East, and Africa

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = var.use_failover_dns ? "${var.webapp_name}-glob" : "${var.webapp_name}-prim"
    viewer_protocol_policy = "allow-all"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = var.whitelist_locations
    }
  }

  tags = var.extra_tags

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
