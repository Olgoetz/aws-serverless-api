variable "region" {
  type        = string
  description = "Region to deploy resources into"
  default     = "eu-central-1"
}

variable "default_tags" {
  type        = map(any)
  description = "Default tags to apply to all resources"
  default     = {}
}