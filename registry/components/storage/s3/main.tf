
#########################
# BUCKET
#########################

resource "aws_s3_bucket" "bucket" {

  region = var.bucket_region != "" ? var.bucket_region : null

  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  # Encryption options
  dynamic "server_side_encryption_configuration" {
    for_each = var.sse_config
    content {
      rule {
        bucket_key_enabled = server_side_encryption_configuration.value.bucket_key_enabled
        apply_server_side_encryption_by_default {
          sse_algorithm     = server_side_encryption_configuration.value.sse_key == "S3" ? "AES256" : "aws:kms"
          kms_master_key_id = server_side_encryption_configuration.value.sse_key == "S3" ? "" : server_side_encryption_configuration.value.sse_key
        }
      }
    }
  }
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule

    content {
      id                                     = lifecycle_rule.value.id
      prefix                                 = lifecycle_rule.value.prefix
      enabled                                = lifecycle_rule.value.enabled
      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration_config

        content {
          days                         = expiration.value.days
          expired_object_delete_marker = expiration.value.expired_object_delete_marker
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration_config

        content {
          days = noncurrent_version_expiration.value.days
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transitions_config

        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transitions_config

        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

resource "aws_s3_bucket_policy" "policy" {
  count = var.bucket_policy != "" ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  policy = var.bucket_policy
}

# S3 Bucket Ownership Controls (Enable or Disable ACLs)
resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.bucket_ownership_controls
  }
}