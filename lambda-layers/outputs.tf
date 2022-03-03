output "lambda_layer_name" {
  value = aws_lambda_layer_version.this.layer_name
}

output "lambda_layer_arn" {
  value = aws_lambda_layer_version.this.arn
}