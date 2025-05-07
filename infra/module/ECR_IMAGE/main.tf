/* ECR Creation */
resource "aws_ecr_repository" "ecs_image_repo" {
  name                 = var.ecr_image_repo
  image_tag_mutability = "MUTABLE" ## to overwrite with different image but with same tag
}

# data "aws_ecr_image" "web_ecr_images" {
#   repository_name = aws_ecr_repository.ecs_image_repo.name
#   image_tag = each.value.image_tag
# }