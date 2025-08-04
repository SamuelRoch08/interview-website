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
  bucket_versioning         = "Disabled"
  bucket_ownership_controls = "BucketOwnerPreferred"
  force_destroy             = true
}

resource "null_resource" "synchro_project" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset("${var.webapp_src_code}/src/", "**") : filesha1("${var.webapp_src_code}/src/${f}")]))
  }
  provisioner "local-exec" {
    command = "aws s3 sync ${var.webapp_src_code}/build s3://${module.s3.bucket_id} --delete --profile ${var.profile}"
  }
}
