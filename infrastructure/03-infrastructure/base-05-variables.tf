variable "ecs-cluster-name" {
  type = string
  default = "codehunters-ecs-cluster"
}

variable "public-subnets" {
  description = "List of public subnets"
  type = list(string)
  default = [ "10.0.1.0/24",  "10.0.2.0/24"]
}

variable "private-subnets" {
  description = "List of private subnets"
  type = list(string)
  default = [ "10.0.100.0/24",  "10.0.101.0/24"]
}

variable "availability-zones" {
  description = "List of availability zones"
  type = list(string)
  default = [ "eu-central-1a",  "eu-central-1b"]
}