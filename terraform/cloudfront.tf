## something something allows cloudfront to access the bucket
resource "aws_cloudfront_origin_access_identity" "main" {}

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
        domain_name = "${aws_s3_bucket.site_bucket.bucket_regional_domain_name}"
        origin_id   = "${local.s3_origin_id}"

        s3_origin_config {
            origin_access_identity = "${aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path}"
        }
    }

    default_cache_behavior {
        target_origin_id = "${local.s3_origin_id}"

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

    custom_error_response {
        error_code = 404
        response_code = 404
        response_page_path = "/404.html"
    }
}
