#variable "azs" {}


variable "public_subnet_ids" {
  type        = list(string)
  description = "IDs of public subnets"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of private subnets"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}