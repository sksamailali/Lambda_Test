resource "null_resource" "lambda_package" {
  provisioner "local-exec" {
    command = "tar -a -c -f lambda_function.zip rotate_password.py"
  }
}



resource "aws_lambda_function" "password_rotator" {
  function_name = "password-rotator"
  role          = aws_iam_role.lambda_role.arn
  handler       = "rotate_password.lambda_handler"
  runtime       = "python3.9"
  timeout       = 15

  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.password_store.bucket
    }
  }

  filename         = "lambda_function.zip" # Pre-package this or use provisioners
  source_code_hash = filebase64sha256("lambda_function.zip")
}

resource "null_resource" "lambda_package1" {
  provisioner "local-exec" {
    command = "tar -a -c -f lambda_function.zip rotate_password.py"
  }
}

