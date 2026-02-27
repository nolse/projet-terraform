# IP publique de l'instance EC2
output "public_ip" {
  description = "IP publique de l'instance EC2"
  value       = module.ec2.public_ip
}

# ID de l'instance EC2
output "instance_id" {
  description = "ID de l'instance EC2"
  value       = module.ec2.instance_id
}

# ID du volume EBS
output "ebs_id" {
  description = "ID du volume EBS"
  value       = module.ebs.ebs_id
}

# ID du security group
output "sg_id" {
  description = "ID du security group"
  value       = module.security_group.sg_id
}