# Region AWS
variable "aws_region" {
  description = "Region AWS"
  type        = string
  default     = "eu-west-3"
}

# Zone de disponibilité
# Définie une seule fois et partagée entre ec2 et ebs
variable "availability_zone" {
  description = "Zone de disponibilité"
  type        = string
  default     = "eu-west-3a"
}

# ID du VPC
variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

# ID du subnet
variable "subnet_id" {
  description = "ID du subnet"
  type        = string
}

# Taille de l'instance EC2
variable "instance_type" {
  description = "Type de l'instance EC2"
  type        = string
  default     = "t2.micro"
}

# Tags communs
variable "aws_common_tag" {
  description = "Tags communs de l'instance EC2"
  type        = map(string)
  default = {
    Name = "ec2-terraform"
  }
}

# Taille du volume EBS en GB
variable "ebs_size" {
  description = "Taille du volume EBS en GB"
  type        = number
  default     = 10
}

# Nom du security group
variable "sg_name" {
  description = "Nom du security group"
  type        = string
  default     = "sg-terraform"
}

# Nom de la clé SSH
variable "key_name" {
  description = "Nom de la clé SSH"
  type        = string
  default     = "ec2-terraform-key"
}