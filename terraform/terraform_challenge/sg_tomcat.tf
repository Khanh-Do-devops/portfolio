resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat-sg"
  description = "tomcat-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id

}

resource "aws_security_group" "tomcat_alb_sg" {
  name        = "tomcat_alb-sg"
  description = "tomcat_alb-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id

}

resource "aws_vpc_security_group_ingress_rule" "tcp_80_to_tomcat_alb" {
  security_group_id = aws_security_group.tomcat_alb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  description = "tcp_80_to_tomcat_alb"
  
}

resource "aws_vpc_security_group_egress_rule" "tcp_80_tomcat_egress" {
  security_group_id = aws_security_group.tomcat_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  description = "tcp_80_tomcat_egress"
}

resource "aws_vpc_security_group_egress_rule" "tcp_443_tomcat_egress" {
  security_group_id = aws_security_group.tomcat_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
  description = "tcp_443_tomcat_egress"
}

resource "aws_vpc_security_group_ingress_rule" "tcp_443_to_tomcat_alb" {
  security_group_id = aws_security_group.tomcat_alb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
  description = "tcp_443_to_tomcat_alb"
}

resource "aws_vpc_security_group_egress_rule" "tcp_8080_from_tomcat_alb_to_tomcat" {
  security_group_id = aws_security_group.tomcat_alb_sg.id

  referenced_security_group_id = aws_security_group.tomcat_sg.id
  from_port                    = 8080
  ip_protocol                  = "tcp"
  to_port                      = 8080
  description                  = "tcp_8080_from_tomcat_alb_to_tomcat"
}


resource "aws_vpc_security_group_ingress_rule" "tcp_8080_to_tomcat_from_tomcat_alb" {
  security_group_id = aws_security_group.tomcat_sg.id

  referenced_security_group_id = aws_security_group.tomcat_alb_sg.id
  from_port                    = 8080
  ip_protocol                  = "tcp"
  to_port                      = 8080
  description                  = "tcp_8080_to_tomcat_from_tomcat_alb"
}

resource "aws_vpc_security_group_egress_rule" "tcp_3306_to_mysql_from_tomcat" {
  security_group_id = aws_security_group.tomcat_sg.id

  referenced_security_group_id = aws_security_group.mysql_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
  description                  = "tcp_3306_to_mysql_from_tomcat"
}

resource "aws_vpc_security_group_egress_rule" "tcp_11211_to_memcached_from_tomcat" {
  security_group_id = aws_security_group.tomcat_sg.id

  referenced_security_group_id = aws_security_group.memcached_sg.id
  from_port                    = 11211
  ip_protocol                  = "tcp"
  to_port                      = 11211
  description                  = "tcp_11211_to_memcached_from_tomcat"
}

resource "aws_vpc_security_group_egress_rule" "tcp_5672_to_rabbitmq_from_tomcat" {
  security_group_id = aws_security_group.tomcat_sg.id

  referenced_security_group_id = aws_security_group.rabbitmq_sg.id
  from_port                    = 5672
  ip_protocol                  = "tcp"
  to_port                      = 5672
  description                  = "tcp_5672_to_rabbitmq_from_tomcat"
}
