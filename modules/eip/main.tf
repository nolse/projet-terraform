# ------------------------------------------------------
# Création de l'Elastic IP (IP publique)
# "domain = vpc" est la syntaxe moderne recommandée par AWS
# L'association à l'instance EC2 se fera dans le module ec2
# car on a besoin de l'instance_id qui n'est pas encore connu ici
# ------------------------------------------------------
resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = var.eip_name
  }
}