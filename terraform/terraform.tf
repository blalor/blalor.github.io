terraform {
    required_version = ">= 0.11.7"

    backend "s3" {
        # bucket = "…" ## partial
        # region = "…" ## partial
        key = "jekyll-site/terraform.tfstate"
    }
}
