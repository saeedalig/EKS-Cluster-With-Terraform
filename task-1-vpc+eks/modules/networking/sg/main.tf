
resource "aws_security_group" "sg" {
  name        = "custom-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  # Ingress rules
  ingress = [
    for port in var.allowed_ingress_ports : {
      description      = "Inbound traffic on port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = [var.allowed_ingress_cidr]
      ipv6_cidr_blocks = []  # Specify as needed, an empty list for IPv6
      prefix_list_ids  = []  # Specify as needed, an empty list for prefix lists
      security_groups  = []  # Specify as needed, an empty list for security groups
      self             = false
    }
  ]

  # Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group EKS"
  }
}
