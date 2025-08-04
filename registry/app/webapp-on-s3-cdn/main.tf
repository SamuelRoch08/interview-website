# Creation of the bucket s3 
# We disable versionning as the code is versionned in this repo. 
module "s3" {
  source = "../../components/storage/s3"

  bucket_name       = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-${var.webapp_name}"
  bucket_versioning = "Disabled"
  force_destroy     = true
}

module "s3_logs" {
  source = "../../components/storage/s3"

  bucket_name               = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-${var.webapp_name}-logs"
  bucket_versioning         = "Disabled"
  bucket_ownership_controls = "BucketOwnerPreferred"
  force_destroy             = true
}

# Create a distribution with default parameters 
module "cloudfront" {
  source         = "../../components/network/cloudfront-s3"
  webapp_name    = var.webapp_name
  origin_dns     = module.s3.bucket_regional_dns
  s3_bucket_logs = module.s3_logs.bucket_dns
  default_ttl    = 10
}

# Associate the new policy of S3 to allow cloudfront to access the bucket. 
resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = module.s3.bucket_id
  policy = jsonencode(templatefile("${path.module}/s3_cloudfront_access.json.tftpl", {
    s3_arn = module.s3.bucket_arn, 
    cloudfront_arn = module.cloudfront.distribution_arn
  }))
}
resource "aws_s3_bucket_policy" "s3_cloudfront_logs_access" {
  bucket = module.s3_logs.bucket_id
  policy = jsonencode(templatefile("${path.module}/s3_cloudfront_logs_access.json.tftpl", {
    s3_arn = module.s3_logs.bucket_arn, 
    account_id = data.aws_caller_identity.current.account_id,
    cloudfront_arn = module.cloudfront.distribution_arn
  }))
}

# Build the project - It requires you to have npm installed localy (no CICD here)
resource "null_resource" "build_project" {
  # We rebuild the project if a file has changed in the source code
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${var.webapp_src_code}/src/", "**") : filesha1("${var.webapp_src_code}/src/${f}")]))
  }

  provisioner "local-exec" {
    command = "npm run --prefix ${var.webapp_src_code} build"
  }
}

resource "null_resource" "synchro_project" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${var.webapp_src_code}/src/", "**") : filesha1("${var.webapp_src_code}/src/${f}")]))
  }
  provisioner "local-exec" {
    command = "aws s3 sync ${var.webapp_src_code}/build s3://${module.s3.bucket_id} --delete --profile ${var.profile}"
  }

  depends_on = [null_resource.build_project]
}


# DR Components 
module "s3_dr" {
  count = var.dr_region != "" ? (var.dr_region != data.aws_region.current.region ? 1 : 0) : 0
  source = "../../components/storage/s3"

  bucket_name       = "${data.aws_caller_identity.current.account_id}-${var.dr_region}-${var.webapp_name}"
  bucket_versioning = "Disabled"
  force_destroy     = true
}

module "s3_logs_dr" {
  count = var.dr_region != "" ? (var.dr_region != data.aws_region.current.region ? 1 : 0) : 0
  source = "../../components/storage/s3"

  bucket_name               = "${data.aws_caller_identity.current.account_id}-${var.dr_region}-${var.webapp_name}-logs"
  bucket_versioning         = "Disabled"
  bucket_ownership_controls = "BucketOwnerPreferred"
  force_destroy             = true
}

# Associate the new policy of S3 to allow cloudfront to access the bucket. 
resource "aws_s3_bucket_policy" "allow_cloudfront_access_dr" {
  count = var.dr_region != "" ? (var.dr_region != data.aws_region.current.region ? 1 : 0) : 0
  bucket = module.s3_dr[0].bucket_id
  policy = jsonencode(templatefile("${path.module}/s3_cloudfront_access.json.tftpl", {
    s3_arn = module.s3_dr[0].bucket_arn, 
    cloudfront_arn = module.cloudfront.distribution_arn
  }))
}
resource "aws_s3_bucket_policy" "s3_cloudfront_logs_access_dr" {
  count = var.dr_region != "" ? (var.dr_region != data.aws_region.current.region ? 1 : 0) : 0
  bucket = module.s3_logs_dr[0].bucket_id
  policy = jsonencode(templatefile("${path.module}/s3_cloudfront_logs_access.json.tftpl", {
    s3_arn = module.s3_logs_dr[0].bucket_arn, 
    account_id = data.aws_caller_identity.current.account_id,
    cloudfront_arn = module.cloudfront.distribution_arn
  }))
}

# We explicty don't create a synchro between the 2 buckets to share sources between region. 
# Like that we are still able to push code into DR region without the primary bucket
resource "null_resource" "synchro_project_dr" {
  count = var.dr_region != "" ? (var.dr_region != data.aws_region.current.region ? 1 : 0) : 0
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${var.webapp_src_code}/src/", "**") : filesha1("${var.webapp_src_code}/src/${f}")]))
  }
  provisioner "local-exec" {
    command = "aws s3 sync ${var.webapp_src_code}/build s3://${module.s3_dr[0].bucket_id} --delete --profile ${var.profile}"
  }

  depends_on = [null_resource.build_project]
}


# Push the static files into the bucket 
# It requires the project to be build 
# We add an etag for each object so that if this object is modified locally, it will be re-uploaded 
# LIMITATION : 
#   Because it is will synchro files that are build during the APPLY, it cannot synchro during the same apply. -> on tf local, 2 applies are necessary to push changes : 
# - One to build 
# - One to synchro 
# resource "aws_s3_object" "build" {
#   for_each = fileset("${var.webapp_src_code}/build/", "**")

#   bucket       = module.s3.bucket_id
#   key          = each.value
#   source       = "${var.webapp_src_code}/build/${each.value}"
#   etag         = filemd5("${var.webapp_src_code}/build/${each.value}")
#   content_type = lookup(
#     {
#       "html" = "text/html"
#       "js"   = "application/javascript"
#       "css"  = "text/css"
#       "json" = "application/json"
#       "png"  = "image/png"
#       "jpg"  = "image/jpeg"
#       "svg"  = "image/svg+xml"
#     },
#     split(".", each.key)[length(split(".", each.key)) - 1],
#     "application/octet-stream"
#   )

#   depends_on = [null_resource.build_project]
# }
