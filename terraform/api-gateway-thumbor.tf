## the aws thumbor thing is coupled to the api gateway's resource path.  if it's
## under `/thumbor/{proxy+}` it will attempt to resolve images with `/thumbor`
## in the path. :-(

## /{proxy+}
resource "aws_api_gateway_resource" "thumbor_proxy" {
    rest_api_id = "${local.rest_api_id}"

    parent_id = "${aws_api_gateway_rest_api.main.root_resource_id}"
    path_part = "{proxy+}"
}

## ANY /{proxy+}
resource "aws_api_gateway_method" "thumbor_proxy" {
    rest_api_id = "${local.rest_api_id}"

    resource_id = "${aws_api_gateway_resource.thumbor_proxy.id}"
    http_method = "ANY"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "thumbor_proxy" {
    rest_api_id = "${local.rest_api_id}"

    resource_id = "${aws_api_gateway_resource.thumbor_proxy.id}"
    http_method = "${aws_api_gateway_method.thumbor_proxy.http_method}"

    type = "AWS_PROXY"
    uri = "${module.fn_thumbor.invoke_arn}"
    integration_http_method = "POST"
}
