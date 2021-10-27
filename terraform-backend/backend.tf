provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "cyber94-bdeadfield-bucket" {
  bucket = "cyber94-bdeadfield-test-bucket"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration{
    rule {
      apply_server_side_encryption_by_default{
        sse_algorithm = "AES256"
      }
    }
  }

  acl = "private"

  tags = {
    Name = "cyber94_bdeadfield_test_s3_bucket"
  }
}

resource "aws_dynamodb_table" "cyber94_bdeadfield_test_dynamodb_table_lock"{
  name = "cyber94_bdeadfield_test_dynamodb_table_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
