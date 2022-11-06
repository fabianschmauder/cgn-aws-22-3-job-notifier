resource "aws_lambda_function" "test_lambda" {
  function_name = "jobvault"
  filename = "lambda.zip"
  role     = "arn:aws:iam::874515606678:role/LabRole"
  runtime  = "python3.9"
  layers   = [aws_lambda_layer_version.lambda_layer.arn]
  handler  = "index.handler"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "requests.zip"
  layer_name = "requests"

  compatible_runtimes = ["python3.9"]
}