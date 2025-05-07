/* IAM Role and IAM POlicy attach to ECS */

/* IAM Assume Role Policy */
resource "aws_iam_role" "web_assume_iam_role" {
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

/* IAM Role */
resource "aws_iam_role" "web_iam_role" {
  name               = var.iam_role
  assume_role_policy = aws_iam_role.web_assume_iam_role.arn
  managed_policy_arns = aws_iam_policy.web_iam_inline_policy.arn
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
            resource = "*"
          },
          {
            Action = [
              "logs:CreateLogStream",
              "logs:PutLogEvents",
              "logs:CreateLogGroup"
            ]
            Effect   = "Allow"
            resource = "*"
          },
          {
            Action   = ["sns:Publish"]
            Effect   = "Allow"
            resource = "${var.sns_topic}"
          }
        ]
     }
    )
}

