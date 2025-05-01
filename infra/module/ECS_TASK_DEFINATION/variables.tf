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