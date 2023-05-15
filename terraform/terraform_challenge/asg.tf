resource "aws_launch_template" "tomcat-LT" {
  name_prefix   = "tomcat-LT"
  image_id      = var.frontend_ami
  instance_type = var.aws_instance
  key_name      = aws_key_pair.my_public_key.key_name
  user_data     = filebase64(var.tomcat_user_data)

  iam_instance_profile {
    name = "tomcat_ec2_profile"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "description" = "webapp-server"
      "Name"        = "tomcat-server"
    }
  }


  placement {
    availability_zone = "us-east-1a"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.tomcat_sg.id]
  }

}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "tomcat-asg-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.tomcat-asg.name
  adjustment_type        = "ChangeInCapacity"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75
  }

}

resource "aws_autoscaling_group" "tomcat-asg" {
  name                = "tomcat-asg"
  vpc_zone_identifier = [aws_subnet.us_east_1a_public.id, aws_subnet.us_east_1b_public.id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.webapp-TG.arn]

  launch_template {
    id      = aws_launch_template.tomcat-LT.id
    version = "$Latest"

  }

}

resource "aws_iam_instance_profile" "tomcat_ec2_profile" {
  name = "tomcat_ec2_profile"
  role = aws_iam_role.s3_role.name

}

resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.tomcat-asg.name
  lb_target_group_arn    = aws_lb_target_group.webapp-TG.arn
}
