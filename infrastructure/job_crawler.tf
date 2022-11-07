resource "aws_lambda_function" "job_crawler" {
  function_name = "job_crawler"
  s3_bucket     = "job-notifier-src-bucket-21345"
  s3_key        = "job_crawler.zip"
  role          = "arn:aws:iam::534283426081:role/LabRole"
  handler       = "crawler.handler"
  timeout       = 300
  runtime       = "python3.9"
  layers = [aws_lambda_layer_version.requests_layer.arn]

}


resource "aws_lambda_layer_version" "requests_layer" {
  s3_bucket     = "job-notifier-src-bucket-21345"
  s3_key        = "requests-layer.zip"
  layer_name    = "requests-layer"

  compatible_runtimes = ["python3.9"]
}