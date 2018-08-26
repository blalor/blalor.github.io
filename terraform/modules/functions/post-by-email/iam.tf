data "aws_iam_policy_document" "assume" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "exec" {
    statement {
        sid = "deadletter"

        actions = ["sqs:SendMessage"]

        resources = [
            "${aws_sqs_queue.lambda_dead_letter.arn}",
        ]
    }

    ## allow logging
    statement {
        sid = "loggit"

        actions = [
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
        ]

        resources = ["*"]
    }

    ## allow reading and deleting emails
    statement {
        sid = "s3iemailaccess"

        actions = [
            "s3:GetObject",
            "s3:DeleteObject",
        ]

        resources = [
            "arn:aws:s3:::${var.s3_email_bucket}/${var.s3_email_path_prefix}/*"
        ]
    }

    ## allow writing photos to s3
    statement {
        sid = "s3imageaccess"

        actions = [
            "s3:PutObject",
            "s3:ListBucket",
            "s3:ListObjects",
        ]

        resources = [
            "arn:aws:s3:::${var.s3_image_bucket}/${var.s3_image_path_prefix}/*"
        ]
    }
}

resource "aws_iam_role" "lambda" {
    path = "/service-role/"
    name_prefix = "lambda-${local.fn_name}-assume-"
    description = "Permissions for the ${local.fn_name} function"

    assume_role_policy = "${data.aws_iam_policy_document.assume.json}"
}

resource "aws_iam_role_policy" "lambda" {
    name_prefix = "lambda-${local.fn_name}-exec-"
    role = "${aws_iam_role.lambda.id}"

    policy = "${data.aws_iam_policy_document.exec.json}"
}
