resource "aws_lambda_function" "test_lambda" {
  function_name = "jobvault_lambda"
  filename = "lambda.zip"
  role     = "arn:aws:iam::326202573469:role/LabRole"
  runtime  = "python3.9"
  layers   = [aws_lambda_layer_version.lambda_layer.arn]
  handler  = "jobvault_lambda.lambda_handler"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "requests.zip"
  layer_name = "requests"

  compatible_runtimes = ["python3.9"]
}