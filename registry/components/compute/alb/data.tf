data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_subnet" "deploy_subnet" {
  id = var.lb_subnets[0]
}

locals {
  elb_accounts = {
    eu-west-1 = "156460612806"
    us-east-1 = "127311923021"
  }
}

data "aws_iam_policy_document" "logging" {
  count = var.enable_lb_access_logging ? 1 : 0
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${lookup(local.elb_accounts, data.aws_region.current.region)}:root"] # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#attach-bucket-policy
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${module.s3_logs[0].bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        "arn:aws:elasticloadbalancing:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:loadbalancer/*"
      ]
    }
  }
}
