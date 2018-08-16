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
