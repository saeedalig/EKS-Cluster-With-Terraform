# Accessing VPC outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}


# Accessing NAT Gateway outputs
output "nat_gateway_ids" {
  value = module.nat.nat_gateway_ids
}

output "eip_ids" {
  value = module.nat.eip_ids
}

