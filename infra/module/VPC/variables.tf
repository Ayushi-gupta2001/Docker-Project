variable "vpc" {
  type = string
}

variable "route_table" {
  type = string
}

variable "public_subent" {
  type = list(string)
}

variable "internet_gateway" {
  type = string
}