provider "aws" {
  region = "us-east-1"
}

module "database" {
  source = "../../../modules/data-stores/mysql"
  env = "stage"
  secret-id = "stg-password-terraform-db"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-jsanchez"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}