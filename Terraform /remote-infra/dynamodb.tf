resource "aws_dynamodb_table" "remote_dynamodb" {
  name           = "remote_backend_table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }

  tags = {
    Name        = "remote_backend_table"
  }
}