resource "aws_cloudfront_vpc_origin" "main_alb" {
  vpc_origin_endpoint_config {
    name                   = "${var.webapp_name}-vpc-orig"
    arn                    = var.main_alb_arn
    http_port              = var.main_alb_config.http_port
    https_port             = var.main_alb_config.https_port
    origin_protocol_policy = var.main_alb_config.protocol_policy
    origin_ssl_protocols {
      items    = var.main_alb_config.ssl_protocols
      quantity = 1
    }
  }
  tags = var.extra_tags
}

resource "aws_cloudfront_vpc_origin" "failover_alb" {
  count = var.use_failover_dns ? 1 : 0
  vpc_origin_endpoint_config {
    name                   = "${var.webapp_name}-vpc-orig-failover"
    arn                    = var.failover_alb_arn
    http_port              = var.failover_alb_config.http_port
    https_port             = var.failover_alb_config.https_port
    origin_protocol_policy = var.failover_alb_config.protocol_policy
    origin_ssl_protocols {
      items    = var.failover_alb_config.ssl_protocols
      quantity = 1
    }
  }
  tags = var.extra_tags
}

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
      http_port              = var.main_alb_config.http_port
      https_port             = var.main_alb_config.https_port
      origin_protocol_policy = var.main_alb_config.protocol_policy
      origin_ssl_protocols   = var.main_alb_config.ssl_protocols
    }
    vpc_origin_config {
      vpc_origin_id = aws_cloudfront_vpc_origin.main_alb.id
    }
  }

  dynamic "origin" {
    for_each = var.use_failover_dns ? [0] : []
    content {
      domain_name = var.failover_dns
      origin_id   = "${var.webapp_name}-failover"
      custom_origin_config {
        http_port              = var.failover_alb_config.http_port
        https_port             = var.failover_alb_config.https_port
        origin_protocol_policy = var.failover_alb_config.protocol_policy
        origin_ssl_protocols   = var.failover_alb_config.ssl_protocols
      }
      vpc_origin_config {
        vpc_origin_id = aws_cloudfront_vpc_origin.failover_alb[0].id
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
