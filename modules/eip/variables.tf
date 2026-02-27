# ID du security group créé par le module security_group
# Passé en variable pour être réutilisé dans l'output
# et transmis au module ec2
variable "sg_id" {
  description = "ID du security group à associer"
  type        = string
}

# Tag Name de l'EIP
variable "eip_name" {
  description = "Tag Name de l'Elastic IP"
  type        = string
  default     = "eip-terraform"
}