output "db_address" {
  value = aws_db_instance.mysqldb.address
}
output "db_port" {
  value = aws_db_instance.mysqldb.port
}

output "password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)[var.secret-id]
}