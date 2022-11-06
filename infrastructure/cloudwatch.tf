resource "aws_cloudwatch_event_rule" "arbeitnow" {
  name        = "Arbeitnow_lambda_rule"
  description = "Invoke arbeitnow function every 5 minutes"
  schedule_expression = "cron(*/5 * ? * * *)"

}

resource "aws_cloudwatch_event_target" "arbeit" {
  rule      = aws_cloudwatch_event_rule.arbeitnow.name
  arn       = aws_lambda_function.lambda_arbeitnow_func.arn
}