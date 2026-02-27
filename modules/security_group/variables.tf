variable "sg_name" {
  description = "Nom du security group"
  type        = string
}

variable "sg_description" {
  description = "Description du security group"
  type        = string
  default     = "Security group managed by Terraform"
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}