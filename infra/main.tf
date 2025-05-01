### creating ECR and ECS on aws using module terraform

/* Module for IAM Role */

module "web_iam_role" {
  source          = "./module/iam-role"
  iam_assume_role = "web_assume_iam_role"
  iam_role        = "web_iam_role"
  inline_policy   = "web_inline_policy"
  sns_topic       = "web_sns_topic"
}

/* Module for ECS Service creation */
module "web_ecs_service" {
  source      = "./module/ECS_TASK_DEFINATION"
  ecs_cluster = "web_ecs_cluster"
  ecs_service = "web_ecs_service"
  iam_role    = module.web_iam_role.web_iam_role_ecs
  containers = {
    "client_container" = {
      task_defination = "client_task_defination"
      container_name  = "client_container"
      ecr_image       = module.web_ecr_image.ecs_images["client"].image_uri
      host_port       = 3001
      container_port  = 3000
      environment     = var.client_env
      volume_storage  = "client_storage"
    }
    "server_container" = {
      task_defination = "server_task_defination"
      container_name  = "server_container"
      ecr_image       = module.web_ecr_image.ecs_images["server"].image_uri
      host_port       = 9000
      container_port  = 9000
      environment     = var.server_env
      volume_storage  = "server_storage"
    }
    "database_container" = {
      task_defination = "database_task_defination"
      container_name  = "database_container"
      ecr_image       = "postgres:latest"
      host_port       = 7890
      container_port  = 5432
      environment     = var.database_env
      volume_storage  = "database_storage"
    }
  }
}

/* Module for ECR Image creation */
module "web_ecr_image" {
  source         = "./module/ECR_CLUSTER"
  ecr_image_repo = "web_ecs_image_repo"
  image_tag = {
    client = "client"
    server = "server"
  }
}