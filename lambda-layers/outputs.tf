output "lambda_layer_name" {
  value       = aws_lambda_layer_version.this.layer_name
  description = "Name of the lambda layer"
}

output "lambda_layer_arn" {
  value       = aws_lambda_layer_version.this.arn
  description = "ARN of the lambda layer"
}