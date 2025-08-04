# Creation of the bucket s3 
# We disable versionning as the code is versionned in this repo. 
module "s3" {
  source = "../../../components/storage/s3"

  bucket_name       = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-${var.prefix_buckets_name}"
  bucket_versioning = "Disabled"
  force_destroy     = true
}

module "s3_logs" {
  source = "../../../components/storage/s3"

  bucket_name               = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-${var.prefix_buckets_name}-logs"
  bucket_versioning         = "Enabled"
  bucket_ownership_controls = "BucketOwnerPreferred"
  force_destroy             = true
}
