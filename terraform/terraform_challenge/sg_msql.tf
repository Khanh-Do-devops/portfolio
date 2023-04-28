resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "mysql-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "tcp_3306_from_tomcat_to_mysql" {
  security_group_id = aws_security_group.mysql_sg.id

  referenced_security_group_id = aws_security_group.tomcat_sg.id

  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}

resource "aws_vpc_security_group_ingress_rule" "tcp_3306_to_mysql_from_memcached" {
  security_group_id = aws_security_group.mysql_sg.id

  referenced_security_group_id = aws_security_group.memcached_sg.id
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}

resource "aws_vpc_security_group_ingress_rule" "tcp_3306_to_mysql_from_rabbitmq" {
  security_group_id = aws_security_group.mysql_sg.id

  referenced_security_group_id = aws_security_group.rabbitmq_sg.id
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}

resource "aws_vpc_security_group_ingress_rule" "tcp_22_to_mysql" {
  security_group_id = aws_security_group.mysql_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "tcp_80_mysql_egress" {
  security_group_id = aws_security_group.mysql_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "tcp_443_mysql_egress" {
  security_group_id = aws_security_group.mysql_sg.id

  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}