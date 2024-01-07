#VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
    Environment = "dev"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1   // Required for Load Balancer
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnets, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
    Environment = "dev"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal-elb"    = 1
  }
}

# Internet Gateway for Public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

# Public Route Table Association with Public Subnets
resource "aws_route_table_association" "public__rta" {
  count           = length(var.public_subnets)
  subnet_id       = element(var.public_subnets, count.index)
  route_table_id  = aws_route_table.public_route_table.id
}







