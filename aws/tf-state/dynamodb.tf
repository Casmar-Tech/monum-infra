resource "aws_dynamodb_table" "tf_state_lock" {
  name         = "tf-state-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "tf-state-lock"
  }
}
