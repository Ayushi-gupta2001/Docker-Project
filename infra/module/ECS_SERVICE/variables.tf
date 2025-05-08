variable "ecs_cluster" {
  type = string
}

variable "containers" {
  type = map(object({
    task_defination = string
    container_name  = string
    ecr_image       = string
    host_port       = optional(number)
    container_port  = optional(number)
    environment     = map(string)
    service_name    = string
  }))
}

variable "execution_role" {
  type = string
}

variable "subnet" {
  type = list(string)
}

variable "security_group" {
  type = string
}

variable "lb_listener_group" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = string
}