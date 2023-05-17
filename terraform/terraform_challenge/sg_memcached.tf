resource "aws_security_group" "memcached_sg" {
  name        = "memcached-sg"
  description = "memcached-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id

}

resource "aws_vpc_security_group_ingress_rule" "tcp_11211_to_memcached_from_tomcat" {
  security_group_id = aws_security_group.memcached_sg.id

  referenced_security_group_id = aws_security_group.tomcat_sg.id
  from_port                    = 11211
  ip_protocol                  = "tcp"
  to_port                      = 11211
  description                  = "tcp_11211_to_memcached_from_tomcat"
}

resource "aws_vpc_security_group_ingress_rule" "tcp_11211_to_memcached_from_rabbitmq" {
  security_group_id = aws_security_group.memcached_sg.id

  referenced_security_group_id = aws_security_group.rabbitmq_sg.id
  from_port                    = 11211
  ip_protocol                  = "tcp"
  to_port                      = 11211
  description                  = "tcp_11211_to_memcached_from_rabbitmq"
}

resource "aws_vpc_security_group_egress_rule" "tcp_3306_from_memcached_to_mysql" {
  security_group_id = aws_security_group.memcached_sg.id

  referenced_security_group_id = aws_security_group.mysql_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
  description                  = "tcp_3306_from_memcached_to_mysql"
}

resource "aws_vpc_security_group_egress_rule" "tcp_80_memcached_egress" {
  security_group_id = aws_security_group.memcached_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  description = "tcp_80_memcached_egress"
}

resource "aws_vpc_security_group_egress_rule" "tcp_443_memcached_egress" {
  security_group_id = aws_security_group.memcached_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
  description = "tcp_443_memcached_egress"
}
