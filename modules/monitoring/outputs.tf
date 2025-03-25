output "sns_topic_arn" {
  description = "ARN of the SNS topic for monitoring alerts"
  value       = aws_sns_topic.monitoring_alerts.arn
}