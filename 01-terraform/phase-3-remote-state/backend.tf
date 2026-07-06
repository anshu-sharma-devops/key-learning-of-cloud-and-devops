# Backend configuration will be added after creating:
# 1. S3 bucket for remote Terraform state
# 2. DynamoDB table for state locking
#
# We cannot use the backend before the bucket and table exist.

# Example backend will be added later:
#
# terraform {
#   backend "s3" {
#     bucket         = "anshu-devops-terraform-state"
#     key            = "phase-3-remote-state/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-state-lock"
#     encrypt        = true
#   }
# }
terraform {
  backend "s3" {
    bucket         = "anshu-devops-terraform-state"
    key            = "01-terraform/phase-3-remote-state/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}