/* ECS Cluster Creation */
resource "aws_ecs_cluster" "web_ecs_clutser" {
  name = var.ecs_cluster
}

/* ECS Task Defination */
/* This task definition will create one task definition per container */
resource "aws_ecs_task_definition" "web_task_defination" {
  requires_compatibilities = ["FARGATE"]
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

  volume {
    name      = each.value.volume_storage
    host_path = "/etc/${each.value.volume_storage}"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

/* ECS services */
resource "aws_ecs_service" "web_service" {
  cluster         = aws_ecs_cluster.web_ecs_clutser.id
  iam_role        = var.iam_role
  depends_on      = [var.iam_role_policy]
  for_each        = var.containers
  name            = each.value.service_name
  task_definition = aws_ecs_task_definition.web_task_defination[each.key].arn
  # network_configuration {
  #   subnets = [var.subnet]
  #   security_groups = [var.security_groups]
  # }

  # load_balancer {
  #   target_group_arn = var.lb_listener_group
  #   container_name = module.web_ecs_service.web_ecs_task_defination
  #   container_port = 3000
  # }
}