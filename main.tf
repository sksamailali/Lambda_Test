provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/Users/Samail/.aws/credentials"]
}
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "/Users/Samail/happylearning/terraform/lambda-test1/rotate_password.py"
  output_path = "/Users/Samail/happylearning/terraform/lambda-test1/lambda_function.zip"
}

