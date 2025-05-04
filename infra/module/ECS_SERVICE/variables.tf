variable "ecs_cluster" {
    type = string
}

variable "ecs_service" {
    type = string
}

variable "iam_role" {
    type = string
}

variable "containers" {
  type = map(object({
    task_defination = string
    container_name  = string
    ecr_image       = string
    host_port       = optional(number)
    container_port  = optional(number)
    environment = map(string)
    volume_storage = string
    host_path = string
  }))
}

variable "subnet" {
  type = string
}

variable "security_groups" {
  type = string
}

variable "lb_listener_group" {
  type = string
}

variable "task_defination" {
  type = map(object({
    task_defination = string
  }))
}

variable "container_name" {
  type = string
}