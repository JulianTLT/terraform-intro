provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-jsanchez"
    key = "workspaces-example1/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "Terraform-up-and-running-locks"
    encrypt = true
  }
}

resource "aws_instance" "example" {
  ami = "ami-4ae27e22"
  instance_type = "t2.micro"
}