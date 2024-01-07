variable "cluster_name" {
  type        = string
  description = "Name for the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of private subnets"
}
variable "node-group_name" {}