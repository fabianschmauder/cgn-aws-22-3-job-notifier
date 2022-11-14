resource "aws_lambda_function" "job_notifier" {
  function_name = "notifer"
  filename       = "build/notifier.zip"
  role          = "arn:aws:iam::534283426081:role/LabRole"
  handler       = "notifier.handler"
  timeout       = 300
  runtime       = "python3.9"
  source_code_hash = filebase64sha256("build/notifier.zip")

  environment {
    variables = {
        TOPIC_ARN = aws_sns_topic.jobs_topic.arn
    }
  }
}

resource "aws_lambda_event_source_mapping" "job_table_update" {
  event_source_arn  = aws_dynamodb_table.jobs.stream_arn
  function_name     = aws_lambda_function.job_notifier.arn
  starting_position = "LATEST"
}

resource "aws_sns_topic" "jobs_topic" {
  name = "jobstopic"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.jobs_topic.arn
  protocol  = "email"
  endpoint  = "fabian.schmauder@neuefische.de"
}
