variable "vpc_id" {
  description = "ID VPC для ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "Список ID публічних підмереж для ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Назва цільової групи для ALB"
  type        = string
  default     = "asg-target-group"
}

variable "alb_name" {
  description = "Назва ALB"
  type        = string
  default     = "my-alb"
}

variable "security_group_id" {
  description = "ID групи безпеки для ALB"
  type        = string
}