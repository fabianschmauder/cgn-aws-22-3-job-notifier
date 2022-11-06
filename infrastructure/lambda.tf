# data "archive_file" "zip_the_python_code" {
# type        = "zip"
# source_dir  = "${path.module}/python/"
# output_path = "${path.module}/python/lambda_func.zip"
# }


resource "aws_lambda_function" "lambda_arbeitnow_func" {
  function_name = "arbeitnow"
  filename = "arbeitnow_func.zip"
  handler = "lambda.lambda_handler"
  role     = "arn:aws:iam::874515606678:role/LabRole"
  runtime  = "python3.9"
  layers   = [aws_lambda_layer_version.lambda_layer.arn]
  timeout = "120"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "${path.module}/requests.zip"
  layer_name = "requests"
  compatible_runtimes = ["python3.9"]
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_arbeitnow_func.function_name
  principal     = "events.amazonaws.com"
}