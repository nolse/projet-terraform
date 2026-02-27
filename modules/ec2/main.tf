# ------------------------------------------------------
# Récupération dynamique de la dernière AMI Ubuntu Bionic Pro 18.04
# owners = "099720109477" est l'ID Canonical (éditeur officiel Ubuntu)
# La version gratuite n'étant plus disponible, on cible ubuntu-pro-server
# Les filtres garantissent : architecture x86_64, disque EBS persistant,
# virtualisation HVM moderne
# ------------------------------------------------------
data "aws_ami" "ubuntu_bionic" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-pro-server/images/hvm-ssd/ubuntu-bionic-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ------------------------------------------------------
# Création de l'instance EC2
# ------------------------------------------------------
resource "aws_instance" "this" {
  ami               = data.aws_ami.ubuntu_bionic.id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  subnet_id         = var.subnet_id
  key_name          = var.key_name

  # Association du security group (ports 80, 443, 22)
  vpc_security_group_ids = [var.sg_id]

  # Tags variabilisés via aws_common_tag
  tags = var.aws_common_tag

  root_block_device {
    delete_on_termination = true
  }

  # ------------------------------------------------------
  # Installation de Nginx via SSH (remote-exec)
  # Ubuntu utilise apt-get contrairement à Amazon Linux
  # qui utilise yum/amazon-linux-extras
  # ------------------------------------------------------
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # utilisateur par défaut sur Ubuntu
      private_key = file("./../../.secrets/${var.key_name}.pem")
      host        = self.public_ip
    }
  }
}

# ------------------------------------------------------
# Attachement du volume EBS à l'instance
# /dev/xvdf est le device standard pour un volume secondaire
# IMPORTANT : l'AZ du volume et de l'instance doivent être identiques
# ------------------------------------------------------
resource "aws_volume_attachment" "this" {
  device_name = "/dev/xvdf"
  volume_id   = var.ebs_id
  instance_id = aws_instance.this.id
}

# ------------------------------------------------------
# Association de l'EIP à l'instance EC2
# ------------------------------------------------------
resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = var.eip_id
}

# ------------------------------------------------------
# Sauvegarde de l'IP publique dans ip_ec2.txt en local
# depends_on garantit que l'EIP est bien associée avant
# d'écrire le fichier
# ------------------------------------------------------
resource "null_resource" "save_ip" {
  depends_on = [aws_eip_association.this]

  provisioner "local-exec" {
    command = "echo ${var.public_eip} > ip_ec2.txt"
  }
}