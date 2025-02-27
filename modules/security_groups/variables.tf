variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "bastion_ingress_ip" {
  description = "Public IP address"
  type        = string
}

variable "bastion_sg_name" {
  description = "Name of the Bastion security group"
  type        = string
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
}

variable "asg_sg_name" {
  description = "Name of the ASG security group"
  type        = string
}

variable "rds_sg_name" {
  description = "Name of the RDS security group"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}