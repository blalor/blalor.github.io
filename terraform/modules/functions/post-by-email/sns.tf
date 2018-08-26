## subscription to events for received email messages
resource "aws_sns_topic_subscription" "pbe" {
    topic_arn = "${var.topic_arn}"
    protocol = "lambda"
    endpoint = "${aws_lambda_function.fn.arn}"
}
