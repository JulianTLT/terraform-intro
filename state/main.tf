provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-jsanchez"
  # Prevent accidental deletion of this bucket
  lifecycle {
    prevent_destroy = true
  }
  # Enabling versioning so we can see the full revision history
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  hash_key = "LockID"
  name = "Terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-jsanchez"
    key = "workspaces-example/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "Terraform-up-and-running-locks"
    encrypt = true
  }
}

resource "aws_instance" "example" {
  ami = "ami-4ae27e22"
  instance_type = "t2.micro"
}
