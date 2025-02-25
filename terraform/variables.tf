variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for public subnet 1 (Bastion)"
  type        = string
  default     = "10.0.0.0/27"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for public subnet 2 (ALB/NAT)"
  type        = string
  default     = "10.0.0.32/27"
}

variable "private_app_subnet_cidr_1" {
  description = "CIDR block for private app subnet 1 (LLM1)"
  type        = string
  default     = "10.0.0.64/26"
}

variable "private_app_subnet_cidr_2" {
  description = "CIDR block for private app subnet 2 (LLM2)"
  type        = string
  default     = "10.0.0.128/26"
}

variable "private_db_subnet_cidr" {
  description = "CIDR block for private DB subnet (PostgreSQL)"
  type        = string
  default     = "10.0.0.192/26"
}