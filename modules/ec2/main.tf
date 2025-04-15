resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.bastion_instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.bastion_sg_id]
  subnet_id                   = var.bastion_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "monitoring" {
  ami                         = var.ami
  instance_type               = var.monitoring_instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.monitoring_sg_id]
  subnet_id                   = var.monitoring_subnet_id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.ebs_volume_size
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name        = "monitoring-instance"
    Environment = "production"
    Role        = "monitoring"
  }
}

resource "aws_launch_template" "asg" {
  name_prefix   = "asg-lt-"
  image_id      = var.ami
  instance_type = var.asg_instance_type
  key_name      = var.key_name
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.asg_sg_id]
    subnet_id                   = element(var.private_subnet_ids, 0)
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.ebs_volume_size
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  tags = {
    Name = "asg-launch-template"
  }
}

resource "aws_autoscaling_group" "main" {
  name                = "asg-llm"
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [var.alb_target_group_arn]
  health_check_type   = "EC2"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

  launch_template {
    id      = aws_launch_template.asg.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-llm-instance"
    propagate_at_launch = true
  }
}

data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.main.name]
  }
}