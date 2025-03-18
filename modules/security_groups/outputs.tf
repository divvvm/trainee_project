output "bastion_sg_id" {
  description = "ID of the Bastion security group"
  value       = aws_security_group.bastion.id
}

output "alb_sg_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "asg_sg_id" {
  description = "ID of the ASG security group"
  value       = aws_security_group.asg.id
}

output "rds_sg_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds.id
}

output "monitoring_sg_id" {
  description = "ID of the monitoring security group"
  value       = aws_security_group.monitoring.id
}