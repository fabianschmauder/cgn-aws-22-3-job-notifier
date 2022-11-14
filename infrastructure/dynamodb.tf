resource "aws_dynamodb_table" "jobs" {
  name             = "jobs"
  hash_key         = "id"

  attribute {
    name = "id"
    type = "S"
  }

  read_capacity = 5
  write_capacity = 5

}
