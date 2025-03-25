variable "slack_webhook_url" {
  description = "Slack Webhook URL for notifications"
  type        = string
  sensitive   = true
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic to subscribe to"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda execution"
  type        = string
}