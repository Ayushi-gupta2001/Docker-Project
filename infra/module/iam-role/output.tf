output "web_iam_role_ecs" {
  value = aws_iam_role.web_iam_assume_role.arn
}

output "web_iam_role_policy" {
  value = aws_iam_policy.web_iam_inline_policy.name
}