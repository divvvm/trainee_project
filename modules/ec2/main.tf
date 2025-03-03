resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.bastion_sg_id]
  subnet_id                   = var.bastion_subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_launch_template" "asg" {
  name_prefix   = "asg-lt-"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.asg_sg_id]
    subnet_id                   = element(var.private_subnet_ids, 0)
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
    version = "$Latest" # Використовуємо найновішу версію шаблону
  }

  tag {
    key                 = "Name"
    value               = "asg-llm-instance"
    propagate_at_launch = true
  }
}