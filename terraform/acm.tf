resource "aws_acm_certificate" "main" {
    ## cert must be in us-east-1 for cloudfront
    provider = "aws.us-east-1"

    domain_name = "${var.site_name}"
    # subject_alternative_names = []

    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "main" {
    certificate_arn = "${aws_acm_certificate.main.arn}"
    validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}
