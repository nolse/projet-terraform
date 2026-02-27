# ID de l'instance EC2 créée
output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.this.id
}

# IP publique de l'instance après association de l'EIP
output "public_ip" {
  description = "IP publique de l'instance EC2"
  value       = var.public_eip
}