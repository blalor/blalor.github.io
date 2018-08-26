module "fn_post_by_email" {
    source = "./modules/functions/post-by-email"

    bucket = "${aws_s3_bucket.site_bucket.id}"

    package_path = "${path.module}/../post-by-email/dist/post-by-email.zip"

    topic_arn = "${aws_sns_topic.pbe.arn}"

    receiving_domain         = "${local.pbe_fqdn}"
    commit_changes           = "true"
    addr_validation_hmac_key = "${var.addr_validation_hmac_key}"
    git_repo                 = "${var.git_repo}"
    jekyll_prefix            = "jekyll"

    s3_image_bucket          = "${aws_s3_bucket.site_bucket.id}"
    s3_image_path_prefix     = "${local.photos_prefix}"

    s3_email_bucket      = "${aws_s3_bucket.site_bucket.id}"
    s3_email_path_prefix = "${local.emails_prefix}"

    opencage_api_key         = "${var.opencage_api_key}"
}
