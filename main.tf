provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "module-development"
  default_tags {
    tags = var.default_tags
  }
}

# Data Sources
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

# Python dependencies
module "python-api-dependencies" {
  source = "./lambda-layers"

  language            = "python"
  source_file_path    = abspath("${path.module}/serverless_api_requirements.txt")
  lambda_layer_name   = "python-api-dependencies"
  compatible_runtimes = ["python3.8", "python3.9"]
}

