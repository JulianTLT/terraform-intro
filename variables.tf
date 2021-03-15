variable "server_port" {
  description = "The port of the server"
  type = number
  default = 8080
}

variable "instance_security_group_name" {
  description = "Name of the security group"
  type = string
  default = "terraform-asg-example"
}