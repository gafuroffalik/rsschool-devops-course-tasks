provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "spacelift_test" {
  bucket = "spacelift-test1"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.spacelift_test.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

terraform {
  backend "s3" {
    bucket = "spacelift-test1"
    key    = "global/s3/terraform.tfstate"
    region = "ca-central-1"
  }
}