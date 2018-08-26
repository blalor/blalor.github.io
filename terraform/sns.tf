## topic for email receipt notifications
resource "aws_sns_topic" "pbe" {
    name_prefix = "post-by-email-"
    display_name = "post-by-email message-received notifications"
}
