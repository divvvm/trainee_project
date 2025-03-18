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
  default     = "bastion-sg"
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "alb-sg"
}

variable "asg_sg_name" {
  description = "Name of the ASG security group"
  type        = string
  default     = "asg-sg"
}

variable "rds_sg_name" {
  description = "Name of the RDS security group"
  type        = string
  default     = "rds-sg"
}

variable "monitoring_sg_name" {
  description = "Name of the security group for the monitoring instance"
  type        = string
  default     = "monitoring-sg"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}