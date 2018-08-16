variable "site_name" {
    type = "string"
    description = "the domain name of the site"
}

variable "bucket_name" {
    type = "string"
    description = "the name of the s3 bucket where the static site will be stored"
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

data "aws_ip_ranges" "cloudfront" {
    services = ["cloudfront"]
}
