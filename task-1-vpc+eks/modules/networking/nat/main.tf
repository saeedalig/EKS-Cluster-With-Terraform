# EIPs
resource "aws_eip" "eips_nat" {
  count = length(var.public_subnet_ids)
  tags = {
    Name = "EIP-${count.index+1}"
  }
}


# Nat Gateways in both public subnets
resource "aws_nat_gateway" "nat" {
  count             = length(var.public_subnet_ids)

  subnet_id         = var.public_subnet_ids[count.index]
  allocation_id     = aws_eip.eips_nat[count.index].id

  tags = {
    Name = "Nat-${count.index + 1}"
  }
}

# Private Route Tables
resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat[*].id, count.index)
  }
  tags = {
    Name = "Private Route Table-${count.index + 1}"
  }
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private-rta" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_rt[count.index].id
}