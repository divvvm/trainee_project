locals {
  alarm_evaluation_periods = 2
  alarm_period             = 300
  cpu_threshold            = 1
  sns_topic_arn            = aws_sns_topic.monitoring_alerts.arn
}

resource "aws_sns_topic" "monitoring_alerts" {
  name = "monitoring-alerts"
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu" {
  alarm_name          = "asg-llm-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.alarm_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = local.alarm_period
  statistic           = "Average"
  threshold           = local.cpu_threshold
  alarm_description   = "Monitors CPU utilization for ASG LLM instances"
  alarm_actions       = [local.sns_topic_arn]
  dimensions = {
    AutoScalingGroupName = var.asg_identifier
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name          = "rds-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.alarm_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = local.alarm_period
  statistic           = "Average"
  threshold           = local.cpu_threshold
  alarm_description   = "Monitors CPU utilization for RDS VectorDB"
  alarm_actions       = [local.sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = var.rds_identifier
  }
}

module "lambda_slack_notifier" {
  source            = "../lambda_slack_notifier"
  slack_webhook_url = var.slack_webhook_url
  sns_topic_arn     = aws_sns_topic.monitoring_alerts.arn
  lambda_role_arn   = var.lambda_role_arn
}