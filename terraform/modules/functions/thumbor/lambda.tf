resource "aws_lambda_function" "fn" {
    function_name = "${local.fn_name}"

    role = "${aws_iam_role.lambda.arn}"

    s3_bucket = "${module.fingerprinted_bucket_object.bucket}"
    s3_key    = "${module.fingerprinted_bucket_object.object}"

    runtime = "python2.7"
    handler = "image_handler/lambda_function.lambda_handler"
    memory_size = 1536
    timeout = 10

    environment {
        variables = {
            ENABLE_CORS = "no"
            LOG_LEVEL = "INFO"

            SEND_ANONYMOUS_DATA = "Hell no"

            RESPECT_ORIENTATION = "True"

            TC_AWS_ENDPOINT = "https://s3.amazonaws.com"
            TC_AWS_REGION = "${var.bucket_region}"
            TC_AWS_LOADER_BUCKET = "${var.bucket}"
            TC_AWS_LOADER_ROOT_PATH = "${var.photos_path}"
        }
    }
}

resource "aws_lambda_permission" "api_gateway" {
    statement_id = "AllowAPIGatewayInvoke"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.fn.function_name}"
    principal = "apigateway.amazonaws.com"

    source_arn = "${var.api_gateway_exec_arn}"
}
