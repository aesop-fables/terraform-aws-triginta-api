resource "aws_apigatewayv2_api" "app_api" {
  name          = "${var.app_name}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "app_api_stage_default" {
  api_id = aws_apigatewayv2_api.app_api.id
  name   = "$default"
  auto_deploy = true
}
