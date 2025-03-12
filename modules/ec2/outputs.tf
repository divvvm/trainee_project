output "bastion_id" {
  description = "ID of the Bastion EC2 instance"
  value       = aws_instance.bastion.id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.name
}

output "bastion_public_ip" {
  description = "Public IP address of the Bastion instance"
  value       = aws_instance.bastion.public_ip
}

output "webserver_ips" {
  description = "Private IP addresses of the ASG instances"
  value       = data.aws_instances.asg_instances.private_ips
}