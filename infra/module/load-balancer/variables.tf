variable "load_balancer" {
  type = string
}

variable "security_group" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}