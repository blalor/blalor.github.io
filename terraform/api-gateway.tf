resource "aws_api_gateway_rest_api" "main" {
    name = "${var.site_name} services"

    binary_media_types = [
        "*/*"
    ]
}

locals {
    rest_api_id = "${aws_api_gateway_rest_api.main.id}"
}

resource "random_pet" "deployment_trigger" {
    length = 3

    ## https://github.com/hashicorp/terraform/issues/6613
    ## all the things that should trigger a new deployment
    keepers = {
        resource_thumbor_proxy_path = "${aws_api_gateway_resource.thumbor_proxy.path_part}"

        gw_meth_thumbor_proxy_method = "${aws_api_gateway_method.thumbor_proxy.http_method}"
        gw_meth_thumbor_proxy_rsrc   = "${aws_api_gateway_method.thumbor_proxy.resource_id}"
        gw_meth_thumbor_proxy_auth   = "${aws_api_gateway_method.thumbor_proxy.authorization}"

        gw_int_lambda_int_meth = "${aws_api_gateway_integration.thumbor_proxy.integration_http_method}"

        binary_media_types = "${jsonencode(aws_api_gateway_rest_api.main.binary_media_types)}"
    }
}

resource "aws_api_gateway_deployment" "main" {
    depends_on = [
        "aws_api_gateway_integration.thumbor_proxy",
    ]

    rest_api_id = "${local.rest_api_id}"

    stage_name = "photos"
    stage_description = "${random_pet.deployment_trigger.id}"
}
