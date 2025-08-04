data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_cloudfront_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      module.s3.bucket_arn,
      "${module.s3.bucket_arn}/*",
    ]

    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"
      values = [
        module.cloudfront.distribution_arn
      ]
    }
  }
}

data "aws_iam_policy_document" "s3_cloudfront_logs_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${module.s3_logs.bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/CloudFront/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values = [
        "bucket-owner-full-control"
      ]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        module.cloudfront.distribution_arn
      ]
    }
  }
}