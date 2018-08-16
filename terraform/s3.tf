## the bucket where the objects will be stored
resource "aws_s3_bucket" "site_bucket" {
    bucket = "${var.bucket_name}"
    acl = "private"

    tags {
        jekyll = "true"
    }
}

locals {
    s3_origin_id = "myS3Origin" ## ¯\_(ツ)_/¯
}

## policy allowing cloudfront access to the bucket
data "aws_iam_policy_document" "s3_origin_policy" {
    statement {
        actions   = ["s3:GetObject"]
        resources = ["${aws_s3_bucket.site_bucket.arn}/*"]

        principals {
            type        = "AWS"
            identifiers = ["${aws_cloudfront_origin_access_identity.main.iam_arn}"]
        }
    }

    statement {
        actions   = ["s3:ListBucket"]
        resources = ["${aws_s3_bucket.site_bucket.arn}"]

        principals {
            type        = "AWS"
            identifiers = ["${aws_cloudfront_origin_access_identity.main.iam_arn}"]
        }
    }
}

resource "aws_s3_bucket_policy" "s3_origin_policy" {
    bucket = "${aws_s3_bucket.site_bucket.id}"
    policy = "${data.aws_iam_policy_document.s3_origin_policy.json}"
}
