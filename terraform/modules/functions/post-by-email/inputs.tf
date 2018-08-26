variable "bucket" {
    type = "string"
    description = "bucket where deployment package is stored"
}

variable "package_path" {
    type = "string"
    description = "path to the deployment package"
}

variable "topic_arn" {
    type = "string"
    description = "ARN of topic for subscription to email receipt events"
}

variable "receiving_domain" {
    type = "string"
    description = "config: "
}

variable "commit_changes" {
    type = "string"
    description = "config: "
}

variable "addr_validation_hmac_key" {
    type = "string"
    description = "config: "
}

variable "git_repo" {
    type = "string"
    description = "config: "
}

variable "jekyll_prefix" {
    type = "string"
    description = "config: "
}

variable "s3_image_bucket" {
    type = "string"
    description = "config: "
}

variable "s3_image_path_prefix" {
    type = "string"
    description = "config: "
}

variable "s3_email_bucket" {
    type = "string"
    description = "config: "
}

variable "s3_email_path_prefix" {
    type = "string"
    description = "config: "
}

variable "opencage_api_key" {
    type = "string"
    description = "config: "
}

locals {
    fn_name = "post-by-email"
}
