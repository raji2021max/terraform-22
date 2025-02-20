resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name             = "terraform-state-lock"
  hash_key         = "LockID"  # This must match the key used by Terraform for state locking
  read_capacity    = 5   # Adjust as needed
  write_capacity   = 5   # Adjust as needed
  billing_mode     = "PROVISIONED"  # You can also use PAY_PER_REQUEST if you prefer on-demand

  attribute {
    name = "LockID"  # Must match the key used in Terraform's state lock
    type = "S"        # Type should be String
  }
}
