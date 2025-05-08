### creating ECR and ECS on aws using module terraform

/* Module for IAM Role */
module "web_iam_role" {
  source            = "./module/iam-role"
  iam_assume_role   = "web_assume_iam_role"
  iam_inline_policy = "web_iam_inline_policy"
}

/* Module for ECR Image creation */
module "web_ecr_image" {
  source         = "./module/ECR_IMAGE"
  ecr_image_repo = "web_ecs_image_repo"
  image_tag      = ["client_latest", "server_latest"]
}

/* Module for ECS Service creation */
module "web_ecs_service" {
  source         = "./module/ECS_SERVICE"
  execution_role = module.web_iam_role.web_iam_role_ecs
  ecs_cluster    = "web_ecs_cluster"
  containers = {
    "client_container" = {
      task_defination = "client_task_defination"
      container_name  = "client_container"
      ecr_image       = module.web_ecr_image.client_ecr_image
      host_port       = 3000
      container_port  = 3000
      environment     = var.client_env
      service_name    = "client_service"
    }
    "server_container" = {
      task_defination = "server_task_defination"
      container_name  = "server_container"
      ecr_image       = module.web_ecr_image.server_ecr_image
      host_port       = 9000
      container_port  = 9000
      environment     = var.server_env
      service_name    = "server_service"
    }
    "database_container" = {
      task_defination = "database_task_defination"
      container_name  = "database_container"
      ecr_image       = "postgres:latest"
      host_port       = 5432
      container_port  = 5432
      environment     = var.database_env
      service_name    = "postgress_service"
    }
  }
  subnet         = module.web_vpc.subnet_id
  security_group = module.web_security_group.security_group
  # lb_listener_group = module.web_load_balancer.web_lb_target_group
  # container_name    = "swde"
}

/* Module for VPC */
module "web_vpc" {
  source           = "./module/VPC"
  vpc              = "web_vpc"
  route_table      = "web_route_tables"
  public_subnet    = "web_public_subnet"
  internet_gateway = "web_internet_gateway"
}

/* Module for security group*/
module "web_security_group" {
  source         = "./module/security-group"
  vpc_id         = module.web_vpc.vpc_id
  security_group = "web_security_group"
}

/* Module for load_balancer */
# module "web_load_balancer" {
#     source = "./module/load-balancer"
#     name = "web_load_balancer"
#     security_groups = module.web_security_group.security_group
#     subnets = module.

# }