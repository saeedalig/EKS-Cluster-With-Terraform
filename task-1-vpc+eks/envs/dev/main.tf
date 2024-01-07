# Data block to retrieve Availability Zones
data "aws_availability_zones" "available" {}

# VPC
module "vpc" {
  source = "../../modules/networking/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  azs = data.aws_availability_zones.available.names
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets

}

# NAT Gatewat
module "nat" {
  source              = "../../modules/networking/nat"
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  vpc_id              = module.vpc.vpc_id
}

# Security Groups
module "security-group" {
  source                = "../../modules/networking/sg"
  vpc_id                = module.vpc.vpc_id
  allowed_ingress_ports = var.allowed_ingress_ports
  allowed_ingress_cidr  = var.allowed_ingress_cidr
}

# Bastion Host to interact with instances in private subnets
module "bastion" {
  source = "../../modules/compute/bastion-host"
  ami_id = var.ami_id
  instance_type = var.instance_type
  public_subnet_ids = module.vpc.public_subnet_ids
  key_name = var.key_name
  security_group_id = module.security-group.security_group_id
  azs = data.aws_availability_zones.available.names[0]
}


# EKS Cluster
module "eks_cluster" {
  source          = "../../modules/kubernetes/eks"
  cluster_name    = var.cluster_name
  cluster_version = "1.25"  # Specify the desired EKS cluster version
  vpc_id          = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  node-group_name = var.node-group_name
}



