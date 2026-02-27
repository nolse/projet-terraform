# Export de l'ID de l'EIP
# Sera utilisé dans le module ec2 pour associer l'EIP à l'instance
output "eip_id" {
  description = "ID de l'Elastic IP"
  value       = aws_eip.this.id
}

# Export de l'adresse IP publique
# Sera utilisé dans le module ec2 pour écrire l'IP dans ip_ec2.txt
output "public_ip" {
  description = "Adresse IP publique de l'Elastic IP"
  value       = aws_eip.this.public_ip
}

# Re-export du sg_id reçu en entrée
# Permet de le transmettre facilement au module ec2 depuis app
output "sg_id" {
  description = "ID du security group associé"
  value       = var.sg_id
}