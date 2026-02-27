# Type/taille de l'instance EC2 (ex: t2.micro, t2.medium...)
# Sera surchargée depuis le dossier app
variable "instance_type" {
  description = "Type/taille de l'instance EC2"
  type        = string
  default     = "t2.micro"
}

# AMI Ubuntu Bionic 18.04 fixe pour us-east-1
variable "ami_id" {
  description = "AMI Ubuntu Bionic 18.04"
  type        = string
  default     = "ami-0e761650b658ef0a2"
}

# Tags de l'instance sous forme de map
# Sera surchargée depuis le dossier app
variable "aws_common_tag" {
  description = "Tags communs de l'instance EC2"
  type        = map(string)
  default = {
    Name = "ec2-terraform"
  }
}

# ID du security group créé par le module security_group
# Transmis via le module eip
variable "sg_id" {
  description = "ID du security group à associer à l'instance"
  type        = string
}

# ID de l'EIP créée par le module eip
variable "eip_id" {
  description = "ID de l'Elastic IP à associer à l'instance"
  type        = string
}

# IP publique de l'EIP
# Nécessaire pour l'écrire dans ip_ec2.txt via local-exec
variable "public_eip" {
  description = "Adresse IP publique de l'EIP"
  type        = string
}

# ID du volume EBS créé par le module ebs
variable "ebs_id" {
  description = "ID du volume EBS à attacher à l'instance"
  type        = string
}

# Zone de disponibilité
# IMPORTANT : doit être identique à celle du volume EBS
variable "availability_zone" {
  description = "Zone de disponibilité de l'instance EC2"
  type        = string
  default     = "eu-west-3a"
}

# Subnet dans lequel déployer l'instance
variable "subnet_id" {
  description = "ID du subnet pour l'instance EC2"
  type        = string
}

# Nom de la clé SSH (sans extension .pem)
# Nécessaire pour le provisioner remote-exec
variable "key_name" {
  description = "Nom de la clé SSH"
  type        = string
  default     = "ec2-terraform-key"
}