resource "aws_s3_bucket" "src_bucket" {
    bucket = "ip-src-bucket"
}

resource "aws_lambda_function" "job_saver_lambda" {
   function_name = "job-saver-lambda"
   s3_bucket= aws_s3_bucket.src_bucket.id
   s3_key   = "job_lambda.zip"
   role     = "arn:aws:iam::937249386082:role/LabRole"
   runtime  = "python3.8"
   layers   = [aws_lambda_layer_version.requests_layer.arn]
   handler  = "job_lambda.handler"
   timeout = 300
   depends_on = [aws_lambda_layer_version.requests_layer]
 }

 resource "aws_lambda_layer_version" "requests_layer" {
   layer_name = "requests-layer"
   s3_bucket= aws_s3_bucket.src_bucket.id
   s3_key   = "requests_layer.zip"
   compatible_runtimes = ["python3.8"]
 }