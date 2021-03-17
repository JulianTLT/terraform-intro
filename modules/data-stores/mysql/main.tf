resource "aws_db_instance" "mysqldb" {
  instance_class = "db.t2.micro"
  identifier_prefix = "terraform"
  engine = "mysql"
  allocated_storage = 10
  name = "${var.env}-example_database"
  username = "admin"
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["admin"]
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.secret-id
}