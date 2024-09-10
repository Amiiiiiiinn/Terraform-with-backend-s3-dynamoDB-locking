provider "aws" {
region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {
        bucket = "statebackend55443ameen"
        tags = {
        Name = "MyS3Bucket"
        Environment = "Production"
  }
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = "statebackend55443amin"
        versioning_configuration {
        status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = "statebackend55443amin"

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"  # DynamoDB auto-scales based on usage
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLockTable"
    Environment = "Production"
  }
}
