variable "vpc_id" {
  description = "ID of the VPC for EC2 and ASG"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID of the public subnet for the Bastion"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of IDs for private subnets for the ASG"
  type        = list(string)
}

variable "bastion_sg_id" {
  description = "ID of the security group for the Bastion"
  type        = string
}

variable "asg_sg_id" {
  description = "ID of the security group for the ASG"
  type        = string
}

variable "ami" {
  description = "AMI for EC2 instances (Ubuntu 22.04)"
  type        = string
  default     = "ami-0e1bed4f06a3b463d"
}

variable "bastion_instance_type" {
  description = "Type of Bastion instance"
  type        = string
  default     = "t3.micro"
}

variable "asg_instance_type" {
  description = "Type of ASG instances"
  type        = string
  default     = "t3.xlarge"
}

variable "key_name" {
  description = "Name of the SSH key for the Bastion"
  type        = string
  default     = "bastion-key"
}

variable "ebs_volume_size" {
  description = "Size of the EBS volume for ASG instances"
  type        = number
  default     = 30
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 3
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB target group for ASG"
  type        = string
}