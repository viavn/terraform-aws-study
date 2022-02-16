provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true
  endpoints {
    iam        = "http://localhost:4566"
    lambda     = "http://localhost:4566"
    kms        = "http://localhost:4566"
    ssm        = "http://localhost:4566"
    s3         = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
  }
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/src/lambda_function.py"
  output_path = "nametest.zip"
}

# Lambda
resource "aws_lambda_function" "lambda" {
  filename         = "nametest.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  function_name    = var.lambda_name
  role             = aws_iam_role.lambda_iam.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  timeout          = 30
}

# IAM
resource "aws_iam_role" "lambda_iam" {
  name = var.lambda_iam_name

  assume_role_policy = file("${path.module}/policy.json")
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "additional_policy" {
  count = var.iam_additional_policy != "" ? 1 : 0

  name = "${var.lambda_iam_name}-additional-policy"
  role = aws_iam_role.lambda_iam.id

  policy = var.iam_additional_policy
}

# # CloudWatch 
# resource "aws_cloudwatch_log_group" "lambda_log_group" {
#   name = "/aws/lambda/${var.lambda_name}"

#   retention_in_days = 30
# }
