module "fn_thumbor" {
    source = "./modules/functions/thumbor"

    bucket = "${aws_s3_bucket.site_bucket.id}"
    bucket_region = "${aws_s3_bucket.site_bucket.region}"

    package_path = "${path.module}/../thumbor/dist/image-handler.zip"

    photos_prefix = "${local.photos_prefix}"

    # The /*/* portion grants access from any method on any resource
    # within the API Gateway "REST API".
    api_gateway_exec_arn = "${aws_api_gateway_deployment.main.execution_arn}/*/*"
}
