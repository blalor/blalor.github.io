## cloudfront distribution
resource "aws_cloudfront_distribution" "main" {
    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"

    price_class = "PriceClass_200"

    aliases = ["${var.site_name}"]

    viewer_certificate {
        acm_certificate_arn = "${aws_acm_certificate.main.arn}"
        ssl_support_method = "sni-only"
        minimum_protocol_version = "TLSv1"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    origin {
        origin_id   = "site-origin"
        domain_name = "${aws_s3_bucket.site_bucket.website_endpoint}"
        origin_path = "${local.jekyll_site_prefix}"

        ## using the s3 website setup instead of the s3-specific origin to take
        ## advantage of the index document config.
        custom_origin_config {
            origin_protocol_policy = "http-only"
            http_port = 80

            # … but "http-only"!
            https_port = 443
            origin_ssl_protocols = [ "TLSv1", "TLSv1.1", "TLSv1.2" ]
        }
    }

    origin {
        origin_id   = "thumbor"
        domain_name = "${element(split("/", aws_api_gateway_deployment.main.invoke_url), 2)}"

        custom_origin_config {
            origin_protocol_policy = "https-only"
            http_port = 80 # oh well
            https_port = 443
            origin_ssl_protocols = [ "TLSv1", "TLSv1.1", "TLSv1.2" ]
        }
    }

    default_cache_behavior {
        target_origin_id = "site-origin"

        viewer_protocol_policy = "redirect-to-https"

        allowed_methods = [ "HEAD", "GET" ]
        cached_methods  = [ "HEAD", "GET" ]

        compress = true
        min_ttl = 600

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }
    }

    ordered_cache_behavior {
        target_origin_id = "thumbor"
        path_pattern = "/${element(split("/", aws_api_gateway_deployment.main.invoke_url), 3)}/*"
        viewer_protocol_policy = "redirect-to-https"

        allowed_methods = [ "HEAD", "GET" ]
        cached_methods  = [ "HEAD", "GET" ]

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }
    }
}
