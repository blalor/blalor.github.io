variable "bucket" {
    type = "string"
    description = "bucket where deployment package and images are stored"
}

variable "bucket_region" {
    type = "string"
    description = "the region where the bucket resides"
}

variable "package_path" {
    type = "string"
    description = "path to the deployment package"
}

variable "photos_prefix" {
    type = "string"
    description = "prefix in bucket where images are stored"
}

variable "api_gateway_exec_arn" {
    type = "string"
    description = "full execution arn for the api gateway"
}

locals {
    fn_name = "thumbor"
}
