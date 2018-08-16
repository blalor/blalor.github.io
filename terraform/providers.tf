provider "aws" {
    version = "~> 1.31"
    region = "${var.aws_region}"
}

provider "aws" {
    alias = "us-east-1"

    version = "~> 1.31"
    region = "us-east-1"
}
