output "bastion_public_ip" {
  value = aws_instance.bastion[0].public_ip
}