/* ECS Cluster Creation */
resource "aws_ecs_cluster" "web_ecs_clutser" {
  name = var.ecs_cluster
}

/* ECS Task Defination */
/* This task definition will create one task definition per container */
resource "aws_ecs_task_definition" "web_task_defination" {
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = var.execution_role
  network_mode             = "awsvpc" // allow to share same network on same vpc and security groups connected to it
  cpu                      = 256
  memory                   = 512
  for_each                 = var.containers
  family                   = each.value.task_defination ## name of the task definition
  container_definitions = jsonencode(
    [
      {
        name      = each.value.container_name
        image     = each.value.ecr_image
        cpu       = 10
        memory    = 512
        essential = true
        portMappings = [
          {
            containerPort = each.value.container_port
            hostPort      = each.value.host_port
            protocol      = "tcp"
          }
        ]
        environment = [
          for key, value in each.value.environment : {
            name  = key
            value = value
          }
        ]
      }
    ]
  )
}

/* ECS services */
resource "aws_ecs_service" "web_service" {
  cluster         = aws_ecs_cluster.web_ecs_clutser.id
  for_each        = var.containers
  name            = each.value.service_name
  task_definition = each.value.task_defination

  network_configuration {
    subnets = var.subnet
    security_groups = [var.security_group]
  }

  #  dynamic "load_balancer" {
  #   for_each = each.value.container_name == var.container_name ? [1] : []
  #   content {
  #     target_group_arn = var.lb_listener_group
  #     container_name = each.value.container_name
  #     container_port = each.value.container_port
  #   }
  # }

}