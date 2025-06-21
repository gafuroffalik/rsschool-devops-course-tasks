output "bastion_public_ip" {
  value = aws_instance.bastion_nat.public_ip
}