# Export du sg_id pour être utilisé par le module eip et ec2
output "sg_id" {
  description = "ID du security group créé"
  value       = aws_security_group.this.id
}