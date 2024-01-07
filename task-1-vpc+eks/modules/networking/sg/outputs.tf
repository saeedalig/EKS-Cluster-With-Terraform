# outputs.tf

output "security_group_id" {
  value       = aws_security_group.sg.id
  description = "The ID of the security group"
}

output "security_group_name" {
  value       = aws_security_group.sg.name
  description = "The name of the security group"
}

output "security_group_ingress" {
  value       = aws_security_group.sg.ingress
  description = "The ingress rules of the security group"
}

output "security_group_egress" {
  value       = aws_security_group.sg.egress
  description = "The egress rules of the security group"
}
