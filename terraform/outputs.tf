output "bucket" {
    value = "${aws_s3_bucket.site_bucket.id}"
    ## just to prevent it from being printed to the console
    sensitive = true
}

output "jekyll_site_prefix" {
    value = "${local.jekyll_site_prefix}"
}
