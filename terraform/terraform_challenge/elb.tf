resource "aws_lb" "vprofile_lb" {
  name               = "vprofile-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.us_east_1a_public.id, aws_subnet.us_east_1b_public.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "webapp-TG" {
  name     = "webapp-TG"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vprofile_vpc.id
}

resource "aws_lb_target_group_attachment" "webapp-attach" {
  target_group_arn = aws_lb_target_group.webapp-TG.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

