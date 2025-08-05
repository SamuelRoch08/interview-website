output "app_url" {
  value = "https://${module.cloudfront.distribution_dns}/"
}