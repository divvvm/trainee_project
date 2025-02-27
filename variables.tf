variable "vpc_cidr" {
  default = "10.0.0.0/24"
}

variable "public_subnet_cidr_1" {
  default = "10.0.0.0/28"
}

variable "public_subnet_cidr_2" {
  default = "10.0.0.16/28"
}

variable "private_app_subnet_cidr_1" {
  default = "10.0.0.32/27"
}

variable "private_app_subnet_cidr_2" {
  default = "10.0.0.64/27"
}

variable "private_db_subnet_cidr" {
  default = "10.0.0.96/28"
}

variable "bastion_ingress_ip" {
  default = "0.0.0.0/0"
}

variable "bastion_sg_name" {
  default = "bastion-sg"
}

variable "alb_sg_name" {
  default = "alb-sg"
}

variable "asg_sg_name" {
  default = "asg-sg"
}

variable "rds_sg_name" {
  default = "rds-sg"
}