output "python-api-dependencies" {
  value       = { "layer_arn" = module.python-api-dependencies.lambda_layer_arn, "layer_name" = module.python-api-dependencies.lambda_layer_name }
  description = "ARN and name of the python lambda layer"
}

output "api_gateway_invoke_url" {
  value       = aws_api_gateway_stage.stage.invoke_url
  description = "Invoke URL of the API Gateway"
}