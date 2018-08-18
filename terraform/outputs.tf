output "bucket" {
    value = "${aws_s3_bucket.site_bucket.id}"
}

output "jekyll_site_prefix" {
    value = "${local.jekyll_site_prefix}"
}
