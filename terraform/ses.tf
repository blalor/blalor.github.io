locals {
    pbe_fqdn_canonical = "${var.post_by_email_hostname}.${data.aws_route53_zone.main.name}"
    pbe_fqdn = "${substr(local.pbe_fqdn_canonical, 0, length(local.pbe_fqdn_canonical) - 1)}"
}

resource "aws_ses_domain_identity" "pbe" {
    domain = "${local.pbe_fqdn_canonical}"
}

resource "aws_ses_domain_dkim" "pbe" {
    ## can't have the trailing '.'
    domain = "${local.pbe_fqdn}"
}

## store all email in the s3 bucket
resource "aws_ses_receipt_rule" "pbe" {
    rule_set_name = "default-rule-set" ## special rule set name
    name = "store-s3"
    enabled = true

    recipients = [
        "${local.pbe_fqdn}",
    ]

    scan_enabled = true

    s3_action {
        position = 1
        bucket_name = "${aws_s3_bucket.site_bucket.id}"
        object_key_prefix = "${local.emails_prefix}/"
    }

    depends_on = [ "aws_s3_bucket_policy.s3_origin_policy" ]
}
