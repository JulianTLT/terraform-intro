provider "aws" {
  region = "us-east-1"
}

module "database" {
  source = "../../../modules/data-stores/mysql"
  env = "prod"
  secret-id = "prod-password-terraform-db"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-jsanchez"
    key = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}