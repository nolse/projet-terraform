# Export de l'ID du volume EBS
# Sera utilisé dans le module ec2 pour attacher le volume à l'instance
output "ebs_id" {
  description = "ID du volume EBS créé"
  value       = aws_ebs_volume.this.id
}