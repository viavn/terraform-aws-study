variable "aws_access_key" {
  type    = string
  default = "asd"
}

variable "aws_secret_key" {
  type    = string
  default = "asd"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Region where to provision Lambda"
}

variable "pip_path" {
  type        = string
  default     = "/usr/local/bin/pip"
  description = "Path to your pip installation"
}

variable "lambda_name" {
  type        = string
  default     = "vini_lambda"
  description = "Lambda function name"
}

variable "lambda_iam_name" {
  type        = string
  default     = "lambda_iam"
  description = "Name of IAM for Lambda"
}

variable "lambda_api_name" {
  type        = string
  default     = "lambda_api"
  description = "Name of API Gateway for Lambda"
}

variable "iam_additional_policy" {
  type        = string
  default     = ""
  description = "Additional IAM Policy for Lambda function"
}
