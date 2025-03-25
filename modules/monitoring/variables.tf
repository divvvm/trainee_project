variable "slack_webhook_url" {
  description = "Slack Webhook URL for SNS notifications"
  type        = string
  sensitive   = true
}

variable "asg_identifier" {
  description = "Identifier (name) of the Auto Scaling Group to monitor"
  type        = string
}

variable "rds_identifier" {
  description = "Identifier of the RDS instance to monitor"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda execution"
  type        = string
}