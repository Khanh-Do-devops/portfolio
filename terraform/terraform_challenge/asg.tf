resource "aws_launch_template" "webapp_launch_template" {
  name_prefix   = "webapp-launch-template"
  image_id      = var.frontend_ami
  instance_type = var.aws_instance
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  

  launch_template {
    id      = aws_launch_template.webapp_launch_template.id
    version = "$Latest"
  }
}