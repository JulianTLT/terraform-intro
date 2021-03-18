resource "aws_db_instance" "mysqldb" {
  instance_class = "db.t2.micro"
  identifier_prefix = "${var.env}-terraform"
  engine = "mysql"
  allocated_storage = 10
  name = "${var.env}_example_database"
  username = "admin"
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)[var.secret-id]
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.mysql_security_group.id]
  skip_final_snapshot = true
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.secret-id
}

resource "aws_security_group" "mysql_security_group" {
  name = "mysql_security_group"
}

resource "aws_security_group_rule" "mysql_inbound" {
  from_port = 3306
  protocol = "tcp"
  security_group_id = aws_security_group.mysql_security_group.id
  to_port = 3306
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}