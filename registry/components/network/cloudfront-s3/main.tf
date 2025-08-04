resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.webapp_name}-oac"
  description                       = "OAC created by Terraform"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


resource "aws_cloudfront_distribution" "distribution" {

  dynamic "origin_group" {
    for_each = var.use_failover_bucket ? [0] : []

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
    domain_name              = data.aws_s3_bucket.origin_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = "${var.webapp_name}-prim"
  }

  dynamic "origin" {
    for_each = var.use_failover_bucket ? [0] : []
    content {
      domain_name              = data.aws_s3_bucket.failover_bucket[0].bucket_regional_domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
      origin_id                = "${var.webapp_name}-failover"
    }
  }

  dynamic "logging_config" {
    for_each = var.use_log_bucket != "" ? [0] : []
    content {
      bucket = data.aws_s3_bucket.log_bucket[0].bucket_domain_name
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
    target_origin_id       = var.failover_bucket_name != "" ? "${var.webapp_name}-glob" : "${var.webapp_name}-prim"
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


# Associate the new policy of S3 to allow cloudfront to access the bucket. 
resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = data.aws_s3_bucket.origin_bucket.id
  policy = templatefile("${path.module}/s3_cloudfront_access.json.tftpl", {
    s3_arn         = data.aws_s3_bucket.origin_bucket.arn,
    cloudfront_arn = aws_cloudfront_distribution.distribution.arn
  })
}

resource "aws_s3_bucket_policy" "allow_cloudfront_access_failover" {
  count  = var.use_failover_bucket? 1 : 0
  bucket = data.aws_s3_bucket.failover_bucket[0].id
  policy = templatefile("${path.module}/s3_cloudfront_access.json.tftpl", {
    s3_arn         = data.aws_s3_bucket.failover_bucket[0].arn,
    cloudfront_arn = aws_cloudfront_distribution.distribution.arn
  })
}


resource "aws_s3_bucket_policy" "s3_cloudfront_logs_access" {
  count  = var.use_log_bucket ? 1 : 0
  bucket = data.aws_s3_bucket.log_bucket[0].id
  policy = templatefile("${path.module}/s3_cloudfront_logs_access.json.tftpl", {
    s3_arn         = data.aws_s3_bucket.log_bucket[0].arn,
    account_id     = data.aws_caller_identity.current.account_id,
    cloudfront_arn = aws_cloudfront_distribution.distribution.arn
  })
}