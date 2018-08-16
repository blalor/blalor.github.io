## the bucket where the objects will be stored
resource "aws_s3_bucket" "site_bucket" {
    bucket = "${var.bucket_name}"
    acl = "private"

    website {
        ## required, otherwise accessing /foo/ for /foo/index.html will 404
        index_document = "index.html"
        error_document = "404.html"
    }

    tags {
        jekyll = "true"
    }
}

## policy allowing cloudfront access to the bucket
data "aws_iam_policy_document" "s3_origin_policy" {
    statement {
        actions   = ["s3:GetObject"]
        resources = ["${aws_s3_bucket.site_bucket.arn}/*"]
        principals {
            type        = "*"
            identifiers = [ "*" ]
        }

        condition {
            test = "IpAddress"
            variable = "aws:SourceIp"
            values = [ "${data.aws_ip_ranges.cloudfront.cidr_blocks}" ]

        }
    }

    statement {
        actions   = ["s3:ListBucket"]
        resources = ["${aws_s3_bucket.site_bucket.arn}"]
        principals {
            type        = "*"
            identifiers = [ "*" ]
        }

        condition {
            test = "IpAddress"
            variable = "aws:SourceIp"
            values = [ "${data.aws_ip_ranges.cloudfront.cidr_blocks}" ]

        }
    }
}

resource "aws_s3_bucket_policy" "s3_origin_policy" {
    bucket = "${aws_s3_bucket.site_bucket.id}"
    policy = "${data.aws_iam_policy_document.s3_origin_policy.json}"
}
