resource "random_id" "this" {
  byte_length = 4
}

locals {
  build_path = abspath("${path.module}/dist-${random_id.this.hex}/")
}

# Trigger everytimw
resource "null_resource" "this" {
  triggers = {
    timestamp = timestamp()
  }

  # Download and prepare the dependencies
  provisioner "local-exec" {
    command = "${path.module}/build.sh"
    environment = {
      BUILD_PATH  = local.build_path
      SOURCE_FILE = var.source_file_path
      LANGUAGE    = var.language
    }
  }
}

data "archive_file" "this" {
  depends_on  = [null_resource.this]
  type        = "zip"
  source_dir  = local.build_path
  output_path = "${local.build_path}.zip"
}

resource "aws_lambda_layer_version" "this" {
  layer_name          = var.lambda_layer_name
  compatible_runtimes = var.compatible_runtimes
  filename            = data.archive_file.this.output_path
}