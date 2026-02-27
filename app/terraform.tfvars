# Surcharge des variables pour rendre l'application dynamique
aws_region        = "us-east-1"
availability_zone = "us-east-1d"
vpc_id            = "vpc-0a4622f2417f0a605"   # à remplacer par ton VPC ID
subnet_id         = "subnet-04aefe8518360c64e" # à remplacer par ton Subnet ID
instance_type     = "t3.micro"
ebs_size          = 10
sg_name           = "terraform_app_sg"
key_name          = "ec2-terraform-key"

aws_common_tag = {
  Name        = "ec2-terraform-app"
  Environment = "dev"
  Project     = "terraform-commun"
}