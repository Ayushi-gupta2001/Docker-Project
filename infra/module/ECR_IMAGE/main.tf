/* ECR Creation */
resource "aws_ecr_repository" "ecs_image_repo" {
  name                 = var.ecr_image_repo
  image_tag_mutability = "MUTABLE" ## to overwrite with different image but with same tag
}

/* for_each doesn't accept list as it is orderd and indexed and can have duplicate items */
/* so in case terraform destroy apply some item does get remove, then indexing will cause a error */
data "aws_ecr_image" "web_ecr_images" {
  for_each = toset(var.image_tag) ## making it uniqueness
  repository_name = aws_ecr_repository.ecs_image_repo.name
  image_tag = each.value
}