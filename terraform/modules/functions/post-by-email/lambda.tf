resource "aws_lambda_function" "fn" {
    function_name = "${local.fn_name}"

    role = "${aws_iam_role.lambda.arn}"

    runtime = "python2.7"
    timeout = 300

    s3_bucket = "${module.fingerprinted_bucket_object.bucket}"
    s3_key    = "${module.fingerprinted_bucket_object.object}"

    handler = "post_by_email.lambda_wrapper.handler"

    environment {
        variables = {
            RECEIVING_DOMAIN = "${var.receiving_domain}"
            COMMIT_CHANGES = "${var.commit_changes}"
            ADDR_VALIDATION_HMAC_KEY = "${var.addr_validation_hmac_key}"
            GIT_REPO = "${var.git_repo}"
            JEKYLL_PREFIX = "${var.jekyll_prefix}"
            # GIT_COMMITTER_NAME = "${var.git_committer_name}"
            S3_IMAGE_BUCKET = "${var.s3_image_bucket}"
            S3_IMAGE_PATH_PREFIX = "${var.s3_image_path_prefix}"
            OPENCAGE_API_KEY = "${var.opencage_api_key}"
        }
    }

    dead_letter_config {
        target_arn = "${aws_sqs_queue.lambda_dead_letter.arn}"
    }
}

resource "aws_lambda_permission" "sns" {
    statement_id = "AllowSNSInvokeMailDelivery"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.fn.function_name}"

    principal = "sns.amazonaws.com"

    source_arn = "${var.topic_arn}"
}
