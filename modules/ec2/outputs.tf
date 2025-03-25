output "bastion_id" {
  description = "ID of the Bastion EC2 instance"
  value       = aws_instance.bastion.id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.name
}

output "llm_server_ips" {
  description = "Private IP addresses of the LLM servers from the Auto Scaling Group"
  value       = data.aws_instances.asg_instances.private_ips
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "monitoring_public_ip" {
  description = "Public IP address of the monitoring instance"
  value       = aws_instance.monitoring.public_ip
}