variable "vpc_id" {
  description = "ID of the VPC for the ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of IDs for public subnets for the ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the target group for the ALB"
  type        = string
  default     = "asg-target-group"
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "my-alb"
}

variable "security_group_id" {
  description = "ID of the security group for the ALB"
  type        = string
}