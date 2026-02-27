# ------------------------------------------------------
# Création du volume EBS
# Le volume sera attaché à l'instance EC2 via le module ec2
# IMPORTANT : la zone de disponibilité doit être
# la même que celle de l'instance EC2
# ------------------------------------------------------
resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.ebs_size

  tags = {
    Name = var.ebs_name
  }
}