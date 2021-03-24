variable "user_names" {
  description = "Create IAM users with this names"
  type = list(string)
  default = ["neo", "trinity", "morpheus"]

}

variable "give_neo_cloudwatch_full_access" {
  description = "if true, neo gets full access to  cloudwatch"
  type = bool
}