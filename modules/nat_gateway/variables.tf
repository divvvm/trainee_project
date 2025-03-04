variable "vpc_id" {
  description = "ID of the VPC for the NAT Gateway"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet for the NAT Gateway"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of IDs for private subnets using the NAT Gateway"
  type        = list(string)
}