provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-stage"
  db_remote_state_bucket = "terraform-state-jsanchez"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  max_size = 2
  min_size = 2
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-jsanchez"
    key = "stage/services/web-server-cluster/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}

