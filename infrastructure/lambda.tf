resource "aws_lambda_function" "jobvault_lambda" {
  function_name   = "jobvault_lambda"
  filename        = "lambda.zip"
  role            = "arn:aws:iam::326202573469:role/LabRole"
  runtime         = "python3.9"
  layers          = [aws_lambda_layer_version.lambda_layer.arn]
  handler         = "jobvault_lambda.lambda_handler"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename            = "requests.zip"
  layer_name          = "requests"

  compatible_runtimes = ["python3.9"]
}

resource "aws_cloudwatch_event_rule" "get_the_jobs" {
  name                = "start-job-sucker"
  description         = "Cronlike scheduled Cloudwatch Event"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "jobvault_lambda_lambda" {
    rule              = "${aws_cloudwatch_event_rule.get_the_jobs.name}"
    target_id         = "${aws_lambda_function.jobvault_lambda.id}"
    arn               = "${aws_lambda_function.jobvault_lambda.arn}"
}