resource "aws_lambda_function" "endpoint_lambda" {
  count            = length(var.routes)
  filename         = var.routes[count.index].function.filename
  handler          = var.routes[count.index].function.handler
  source_code_hash = filebase64sha256(var.routes[count.index].function.filename)
  function_name    = var.routes[count.index].function.name
  role             = aws_iam_role.app_role.arn

  environment {
    variables = {
      AWS_PROFILE = "localstack"
    }
  }
  runtime          = var.runtime
  memory_size      = 2048
  timeout          = 600
}

resource "aws_apigatewayv2_integration" "endpoint_lambda_integration" {
  count            = length(var.routes)
  api_id           = aws_apigatewayv2_api.app_api.id
  description      = "${var.routes[count.index].function.name} integration"
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.endpoint_lambda[count.index].invoke_arn
}

resource "aws_apigatewayv2_route" "endpoint_lambda_route" {
  count              = length(var.routes)
  api_id             = aws_apigatewayv2_api.app_api.id
  route_key          = "${var.routes[count.index].method} ${var.routes[count.index].path}"
  authorization_type = "AWS_IAM"

  target             = "integrations/${aws_apigatewayv2_integration.endpoint_lambda_integration[count.index].id}"
}

resource "aws_lambda_permission" "endpoint_lambda_integration_perm" {
    count              = length(var.routes)
    statement_id       = "AllowExecutionFromAPIGateway"
    action             = "lambda:InvokeFunction"
    function_name      = var.routes[count.index].function.name
    principal          = "apigateway.amazonaws.com"
    source_arn         = "${aws_apigatewayv2_api.app_api.execution_arn}/*/*"
}
