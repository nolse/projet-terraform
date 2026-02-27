# Taille du volume EBS en GB
# Sera surchargée depuis le dossier app
variable "ebs_size" {
  description = "Taille du volume EBS en GB"
  type        = number
  default     = 10
}

# Zone de disponibilité du volume EBS
# IMPORTANT : doit être identique à celle de l'instance EC2
# sinon l'attachement du volume échouera
variable "availability_zone" {
  description = "Zone de disponibilité pour le volume EBS"
  type        = string
}

# Tag Name du volume EBS
variable "ebs_name" {
  description = "Tag Name du volume EBS"
  type        = string
  default     = "ebs-terraform"
}