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

module "s3_buckets" {
  source              = "./buckets-and-push"
  prefix_buckets_name = var.webapp_name
  profile             = var.profile
  webapp_src_code     = var.webapp_src_code
  depends_on          = [null_resource.build_project]
}

module "s3_buckets_dr" {
  count = var.secondary_region != "" ? 1 : 0 
  source              = "./buckets-and-push"
  providers = {
    aws = aws.dr
  }
  prefix_buckets_name = var.webapp_name
  profile             = var.profile
  webapp_src_code     = var.webapp_src_code
  depends_on          = [null_resource.build_project]
}

# Create a distribution with default parameters 
module "cloudfront" {
  source           = "../../components/network/cloudfront-s3"
  webapp_name      = var.webapp_name
  main_bucket_name = module.s3_buckets.main_bucket
  use_log_bucket   = true
  log_bucket_name  = module.s3_buckets.log_bucket
  default_ttl      = 10
}

