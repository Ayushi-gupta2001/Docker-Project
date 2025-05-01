/* IAM Role and IAM POlicy attach to ECS */

resource "aws_iam_role" "web_assume_iam_role" {
  name = var.iam_assume_role

  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "ecs.amazonaws.com"
          }
        }
      ]
    }
  )

}

resource "aws_iam_role" "web_iam_role" {
  name               = var.iam_role
  assume_role_policy = aws_iam_role.iam_assume_role.arn

  inline_policy {
    name = var.inline_policy

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

}

