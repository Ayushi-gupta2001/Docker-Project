### creating ECR and ECS on aws using module terraform

/* Module for IAM Role */
module "web_iam_role" {
  source          = "./module/iam-role"
  iam_assume_role = "web_assume_iam_role"
  iam_role        = "web_iam_role"
  inline_policy   = "web_inline_policy"
  sns_topic       = "web_sns_topic"
}

/* Module for ECR Image creation */
module "web_ecr_image" {
  source         = "./module/ECR_IMAGE"
  ecr_image_repo = "web_ecs_image_repo"
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
  subnet = module.web_vpc.subnet_id
  security_groups = module.web_security_group.security_group
  task_defination = {
    "client_task_defination" = {

    },
    "server_task_defination" = {

    },
    "postgress_task_defination" = {

    }
  }
  lb_listener_group = module.web_load_balancer.web_lb_target_group
}

/* Module for VPC */
module "web_vpc" {
    source = "./module/VPC"
    vpc = "web_vpc"
    route_tables = "web_route_tables"
    public_subent = "web_public_subnet"
    internet_gateway = "web_internet_gateway"
}

/* Module for security group*/
module "web_security_group" {
    source = "./module/security-group"
    vpc_id = module.web_vpc.vpc_id
    security_group = "web_security_group"
}

/* Module for load_balancer */
module "web_load_balancer" {
    source = "./module/load-balancer"
    name = "web_load_balancer"
    security_groups = module.web_security_group.security_group
    subnets = module.

}