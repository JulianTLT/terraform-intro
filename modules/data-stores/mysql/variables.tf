variable "env" {
  description = "environment to be deployed"
  type = string
}

variable "secret-id" {
  description = "secret id to retrieve the DB password"
  type = string
}