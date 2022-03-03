provider "aws" {
  region = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "module-development"
}

data "aws_caller_identity" "this" {}
data "aws_region" "this" {}


module "python-api-dependencies" {
  source = "./lambda-layers"

  language = "python"
  source_file_path = abspath("${path.module}/serverless_api_requirements.txt")
  lambda_layer_name = "python-api-dependencies"
  compatible_runtimes = ["python3.8", "python3.9"]
}

