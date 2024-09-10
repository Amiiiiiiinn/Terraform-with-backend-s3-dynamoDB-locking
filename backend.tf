# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.mybucket.bucket
    key            = "global/terraform/state"   # Path to store the state file in S3
    region         = "us-east-1"
    dynamodb_table = aws_dynamodb_table.terraform_locks.name
    encrypt        = true                # Server-side encryption for the state file
  }
}
