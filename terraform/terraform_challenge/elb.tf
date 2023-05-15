resource "aws_lb" "vprofile_lb" {
  name               = "vprofile-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tomcat_alb_sg.id]
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

  health_check {
    port                = 8080
    protocol            = "HTTP"
    path                = "/login"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30

  }
}

resource "aws_lb_listener" "front_end_80" {
  load_balancer_arn = aws_lb.vprofile_lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-TG.arn
  }
}

resource "aws_lb_listener" "front_end_443" {
  load_balancer_arn = aws_lb.vprofile_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:049977130337:certificate/4ce5f8fc-a027-4a18-96e2-ea62ff287743"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-TG.arn
  }
}  
