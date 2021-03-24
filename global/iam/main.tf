provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "user_example" {
  for_each = toset(var.user_names)
  name = each.value
}

resource "aws_iam_policy" "cloudwatch_read_only" {
  name = "cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  name = "cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

resource "aws_iam_policy_attachment" "neo_cloudwatch_full_access" {
  count = var.give_neo_cloudwatch_full_access ? 1 : 0
  user = aws_iam_user.user_example[0].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
  name = "neo_cloudwatch_full_access"
}

resource "aws_iam_policy_attachment" "neo_cloudwatch_read_only" {
  count = var.give_neo_cloudwatch_full_access ? 1 : 0
  user = aws_iam_user.user_example[0].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
  name = "neo_cloudwatch_read_only"
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect = "Allow"
    actions = ["cloudwatch:*"]
    resources = ["*"]
  }
}

