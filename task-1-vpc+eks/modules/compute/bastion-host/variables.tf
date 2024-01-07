variable "ami_id" {
  type        = string
  description = "AMI ID for the Bastion Host"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the Bastion Host"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "IDs of public subnets"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair for SSH access"
}

variable "security_group_id" {
  type        = string
  description = "ID of the security group for the Bastion Host"
}

variable "azs" {}
