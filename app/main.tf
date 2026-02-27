# ------------------------------------------------------
# Configuration du provider AWS
# ------------------------------------------------------
provider "aws" {
  region = var.aws_region
}

# ------------------------------------------------------
# AZ définie une seule fois via locals
# Partagée entre les modules ec2 et ebs
# pour garantir qu'ils sont dans la même zone
# ------------------------------------------------------
locals {
  availability_zone = var.availability_zone
}

# ------------------------------------------------------
# Module Security Group
# Ouvre les ports 80, 443 et 22
# ------------------------------------------------------
module "security_group" {
  source         = "../modules/security_group"
  sg_name        = var.sg_name
  sg_description = "Security group - ports 80, 443, 22"
  vpc_id         = var.vpc_id
}

# ------------------------------------------------------
# Module EBS
# Crée un volume avec la taille variabilisée
# Utilise la même AZ que l'EC2 via locals
# ------------------------------------------------------
module "ebs" {
  source            = "../modules/ebs"
  ebs_size          = var.ebs_size
  availability_zone = local.availability_zone
  ebs_name          = "ebs-${var.aws_common_tag["Name"]}"
}

# ------------------------------------------------------
# Module EIP
# Crée une IP publique et reçoit le sg_id
# ------------------------------------------------------
module "eip" {
  source   = "../modules/eip"
  sg_id    = module.security_group.sg_id
  eip_name = "eip-${var.aws_common_tag["Name"]}"
}

# ------------------------------------------------------
# Module EC2
# Utilise les outputs des 3 modules précédents
# L'AZ est la même que celle du volume EBS via locals
# ------------------------------------------------------
module "ec2" {
  source            = "../modules/ec2"
  instance_type     = var.instance_type
  aws_common_tag    = var.aws_common_tag
  availability_zone = local.availability_zone
  subnet_id         = var.subnet_id
  key_name          = var.key_name

  # Récupération des outputs des modules
  sg_id      = module.eip.sg_id
  eip_id     = module.eip.eip_id
  public_eip = module.eip.public_ip
  ebs_id     = module.ebs.ebs_id
}