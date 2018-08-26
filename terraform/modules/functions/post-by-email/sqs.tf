resource "aws_sqs_queue" "lambda_dead_letter" {
    name_prefix = "${local.fn_name}-dlq-"
}
