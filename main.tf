provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-4ae27e22"
  instance_type = "t2.micro"
  tags = {
    Name = "terraform-example"
  }
}