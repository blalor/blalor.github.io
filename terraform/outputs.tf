output "bucket" {
    value = "${aws_s3_bucket.site_bucket.id}"
}

output "jekyll_site_prefix" {
    value = "${local.jekyll_site_prefix}"
}

output "api_gw_base_url" {
    value = "${aws_api_gateway_deployment.main.invoke_url}"
}
