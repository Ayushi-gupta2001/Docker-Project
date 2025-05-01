variable "database_env" {
  type        = map(string)
  description = "Enviornment variable for database container"
}

variable "client_env" {
  type        = map(string)
  description = "Enviorment variable for client container"
}

variable "server_env" {
  type        = map(string)
  description = "Envoirnemt variable for server container"
}
