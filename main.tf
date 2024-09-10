provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "amin260_bucket"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
################################################# 
# Enable bucket versioning 
################################################# 
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
################################################# 
# S3 bucket server side encryption
################################################# 

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

################################################# 
# Create a DynamoDB table for state locking
################################################# 
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
#################################################
# Terraform backend configuration
#################################################
terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.mybucket.bucket
    key            = "terraform/state"   # Path to store the state file in S3
    region         = "us-east-1"
    dynamodb_table = aws_dynamodb_table.terraform_locks.name
    encrypt        = true                # Server-side encryption for the state file
  }
}
