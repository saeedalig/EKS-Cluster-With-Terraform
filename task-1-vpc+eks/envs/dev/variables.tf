variable "region" {}


variable "vpc_name" {}
variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}

variable "allowed_ingress_ports" {
  description = "List of allowed ingress ports"
  type        = list(number)
}
variable "allowed_ingress_cidr" {
  description = "CIDR block for allowed ingress traffic"
  type        = string
}


variable "key_name" {}
variable "ami_id" {}

variable "instance_type" {}

variable "cluster_name" {}
variable "cluster_version" {}

variable "node-group_name" {}