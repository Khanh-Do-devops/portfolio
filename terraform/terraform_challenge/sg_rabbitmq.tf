resource "aws_security_group" "rabbitmq_sg" {
  name        = "rabbitmq-sg"
  description = "rabbitmq-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id

}

resource "aws_vpc_security_group_ingress_rule" "tcp_22_to_rabbitmq" {
  security_group_id = aws_security_group.rabbitmq_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "tcp_5672_to_rabbitmq_from_tomcat" {
  security_group_id = aws_security_group.rabbitmq_sg.id

  referenced_security_group_id = aws_security_group.tomcat_sg.id
  from_port                    = 5672
  ip_protocol                  = "tcp"
  to_port                      = 5672
  description                  = "tcp_5672_to_rabbitmq_from_tomcat"

}

resource "aws_vpc_security_group_egress_rule" "tcp_11211_from_rabbitmq_to_memcached" {
  security_group_id = aws_security_group.rabbitmq_sg.id

  referenced_security_group_id = aws_security_group.memcached_sg.id
  from_port                    = 11211
  ip_protocol                  = "tcp"
  to_port                      = 11211
  description                  = "tcp_11211_from_rabbitmq_to_memcached"
}

resource "aws_vpc_security_group_egress_rule" "tcp_3306_from_rabbitmq_to_mysql" {
  security_group_id = aws_security_group.rabbitmq_sg.id

  referenced_security_group_id = aws_security_group.mysql_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
  description                  = "tcp_3306_from_rabbitmq_to_mysql"
}

resource "aws_vpc_security_group_egress_rule" "tcp_80_rabbitmq_egress" {
  security_group_id = aws_security_group.rabbitmq_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  description = "tcp_80_rabbitmq_egress"
}

resource "aws_vpc_security_group_egress_rule" "tcp_443_rabbitmq_egress" {
  security_group_id = aws_security_group.rabbitmq_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
  description = "tcp_443_rabbitmq_egress"
}
