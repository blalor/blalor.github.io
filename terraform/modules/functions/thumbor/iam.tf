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
        sid = "getdemphotos"

        actions = [
            "s3:GetObject",
        ]

        resources = [
            "arn:aws:s3:::${var.bucket}/${var.photos_prefix}/*"
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
}

resource "aws_iam_role" "lambda" {
    path = "/service-role/"
    name = "LambdaThumbor"
    description = "Permissions for the ${local.fn_name} function"
    assume_role_policy = "${data.aws_iam_policy_document.assume.json}"
}

resource "aws_iam_role_policy" "lambda" {
    name = "${aws_iam_role.lambda.name}"
    role = "${aws_iam_role.lambda.id}"
    policy = "${data.aws_iam_policy_document.exec.json}"
}
