variable "site_name" {
    type = "string"
    description = "the domain name of the site"
    default = "beta5.org"
}

variable "post_by_email_hostname" {
    type = "string"
    description = "hostname part of fqdn under site_name to serve as endpoint for post-by-email service"
    default = "pbe"
}

variable "aws_region" {
    type = "string"
    description = "the aws region where resources will be created"
    default = "us-east-1"
}

# variable "site_aliases" {
#     type = "list"
#     description = "list of hostnames the site will be served under"
# }

variable "addr_validation_hmac_key" {
    type = "string"
    description = "hmac key for validating sender address"
}

variable "git_repo" {
    type = "string"
    description = "https url -- with credentials -- where the jekyll site lives"
}

variable "opencage_api_key" {
    type = "string"
    description = "api key for opencage, for reverse geocoding photo locations"
}

data "aws_ip_ranges" "cloudfront" {
    services = ["cloudfront"]
}

data "aws_caller_identity" "current" {}

locals {
    ## where in the bucket the static site files exist
    jekyll_site_prefix = "_site"
    photos_prefix = "photos"
    emails_prefix = "emails"
}
