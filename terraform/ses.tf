locals {
    pbe_fqdn = "${var.post_by_email_hostname}.${data.aws_route53_zone.main.name}"
}

resource "aws_ses_domain_identity" "pbe" {
    domain = "${local.pbe_fqdn}"
}

resource "aws_ses_domain_dkim" "pbe" {
    ## can't have the trailing '.'
    domain = "${substr(local.pbe_fqdn, 0, length(local.pbe_fqdn) - 1)}"
}
