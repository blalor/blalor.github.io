data "aws_route53_zone" "main" {
    name = "${var.site_name}"
}

resource "aws_route53_record" "cert_validation" {
    zone_id = "${data.aws_route53_zone.main.zone_id}"

    name = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_name}"
    type = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_type}"
    records = [
        "${aws_acm_certificate.main.domain_validation_options.0.resource_record_value}"
    ]

    ttl = "60"
}

resource "aws_route53_record" "site" {
    zone_id = "${data.aws_route53_zone.main.zone_id}"

    name = "${var.site_name}"
    type = "A"

    alias {
        zone_id = "${aws_cloudfront_distribution.main.hosted_zone_id}"
        name = "${aws_cloudfront_distribution.main.domain_name}"
        evaluate_target_health = false
    }
}

## https://docs.aws.amazon.com/ses/latest/DeveloperGuide/dns-txt-records.html
resource "aws_route53_record" "pbe_verification" {
    zone_id = "${data.aws_route53_zone.main.zone_id}"
    name = "_amazonses.${aws_ses_domain_identity.pbe.domain}"
    type = "TXT"
    ttl = "60"
    records = [
        "${aws_ses_domain_identity.pbe.verification_token}"
    ]
}

resource "aws_route53_record" "pbe_dkim" {
    count = 3

    zone_id = "${data.aws_route53_zone.main.zone_id}"
    name = "${element(aws_ses_domain_dkim.pbe.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.pbe.domain}"
    type = "CNAME"
    ttl = "60"
    records = [
        "${element(aws_ses_domain_dkim.pbe.dkim_tokens, count.index)}.dkim.amazonses.com"
    ]
}

resource "aws_route53_record" "pbe_mx" {
    zone_id = "${data.aws_route53_zone.main.zone_id}"

    name = "${aws_ses_domain_identity.pbe.domain}"
    type = "MX"
    records = [
        "10 inbound-smtp.${var.aws_region}.amazonaws.com"
    ]

    ttl = "60"
}
