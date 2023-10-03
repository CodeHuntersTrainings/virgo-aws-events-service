variable "ecr-enabled" {
  type = bool
  default = false
}

variable "s3-enabled" {
  type = bool
  default = false
}

variable "vpc-enabled" {
  type = bool
  default = false
}

variable "ecs-enabled" {
  type = bool
  default = false
}

variable "kubernetes-enabled" {
  type = bool
  default = false
}

variable "database-enabled" {
  type = bool
  default = false
}

variable "queue-enabled" {
  type = bool
  default = false
}

variable "internet-gw-enabled" {
  type = bool
  default = false
}

variable "nat-gw-enabled" {
  type = bool
  default = false
}

variable "monitoring-enabled" {
  type = bool
  default = false
}