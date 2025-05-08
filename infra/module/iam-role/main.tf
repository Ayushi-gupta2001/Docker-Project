/* IAM Role and IAM POlicy attach to ECS */

/* IAM Assume Role Policy */
resource "aws_iam_role" "web_iam_assume_role" {
  name = var.iam_assume_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })
}

/* IAM Inline Policy */
resource "aws_iam_policy" "web_iam_inline_policy" {
  name = var.iam_inline_policy

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    }
  )
}

/* Attachement of IAM role policy */
resource "aws_iam_role_policy_attachment" "web_iam_role_policy_attachement" {
  role       = aws_iam_role.web_iam_assume_role.name
  policy_arn = aws_iam_policy.web_iam_inline_policy.arn
}