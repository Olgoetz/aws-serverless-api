variable "source_file_path" {
  type = string
  description = "Path of filename with dependencies"
}

variable "language" {
  type = string
  description = "Programming language"
  validation {
    condition = contains(["python", "nodejs"], var.language)
    error_message = "Language must be either 'python' or 'nodejs'."
  }
}

variable "lambda_layer_name" {
  type = string
  description = "Name of the lambda layer"
}

variable "compatible_runtimes" {
  type = list(string)
  description = "List of supported runtimes"
}