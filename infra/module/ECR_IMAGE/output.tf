output "client_ecr_image" {
    value = data.aws_ecr_image.web_ecr_images["client_latest"].image_uri
}

output "server_ecr_image" {
  value = data.aws_ecr_image.web_ecr_images["server_latest"].image_uri
}