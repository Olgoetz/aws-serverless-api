# Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}

data "archive_file" "this" {
  output_path = "${path.module}/python_lambda.zip"
  type        = "zip"
  source_file = "${path.module}/lambda/lambda.py"
}

resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.this.output_path
  function_name = "FastAPI"
  role          = aws_iam_role.role.arn
  handler       = "lambda.handler"
  runtime       = "python3.8"
  layers        = [module.python-api-dependencies.lambda_layer_arn]
  source_code_hash = data.archive_file.this.output_base64sha256
}

# IAM
resource "aws_iam_role" "role" {
  name = "FastAPI-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.role.name
}