resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.webapp_name}-oac"
  description                       = "OAC created by Terraform"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name              = var.origin_dns
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = var.webapp_name
  }

  dynamic "logging_config" {
    for_each = var.s3_bucket_logs != "" ? [0] : []
    content {
      bucket = var.s3_bucket_logs
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
    target_origin_id       = var.webapp_name
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


