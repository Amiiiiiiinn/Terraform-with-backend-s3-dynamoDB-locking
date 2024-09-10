terraform {
backend "s3" {
        bucket ="statebackend55443amin"
        dynamodb_table = "terraform-lock-table"
        key = "global/mystatefile/terraform.tf"
        region = "us-east-1"
        encrypt = true
}
}

