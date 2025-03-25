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

variable "private_db_subnet_cidr_1" {
  default = "10.0.0.96/28"
}

variable "private_db_subnet_cidr_2" {
  default = "10.0.0.112/28"
}

variable "bastion_ingress_ip" {
  default = "0.0.0.0/0"
}

variable "slack_webhook_url" {
  default = "https://hooks.slack.com/services/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"
}

variable "lambda_role_arn" {
  default = "arn:aws:iam::423623847730:role/lambda-slack-notifier-role"
}

