resource "aws_ses_domain_identity" "pbe" {
    domain = "pbe.${data.aws_route53_zone.main.name}"
}

resource "aws_ses_domain_dkim" "pbe" {
    ## can't have the trailing '.'
    domain = "pbe.${substr(data.aws_route53_zone.main.name, 0, length(data.aws_route53_zone.main.name) - 1)}"
}
