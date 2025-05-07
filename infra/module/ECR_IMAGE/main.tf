/* ECR Creation */
resource "aws_ecr_repository" "ecs_image_repo" {
  name                 = var.ecr_image_repo
  image_tag_mutability = "MUTABLE" ## to overwrite with different image but with same tag

  image_scanning_configuration {
    scan_on_push = true ## it adds pricing
  }
}

data "aws_ecr_image" "web_ecr_images" {
  repository_name = aws_ecr_repository.ecs_image_repo.name
  image_tag = each.value.image_tag
}