resource "aws_instance" "bastion" {
  count = 1  # You can adjust the count based on your requirement

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.public_subnet_ids, 0)  # You can adjust this based on your logic
  key_name               = var.key_name
  associate_public_ip_address = true

  # Security Group
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "Bastion-Host"
  }

  # Provisioner to install kubectl to interact with EKS Cluster
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "curl -LO 'https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl'",
      "sudo chmod +x kubectl",
      "sudo mv kubectl /usr/local/bin",
      "sudo apt-get update",
      "kubectl version --output=yaml",
    ]
  }
}

