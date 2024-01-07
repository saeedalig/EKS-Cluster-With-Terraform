output "nat_gateway_ids" {
  value = aws_nat_gateway.nat[*].id
}

output "eip_ids" {
  value = aws_eip.eips_nat[*].id
}

output "private_route_table_ids" {
  value = aws_route_table.private_rt[*].id
}