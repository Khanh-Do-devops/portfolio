resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat-sg"
  description = "tomcat-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id


  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  ingress {
    description = "Allows SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allows SSH"
  }
}

resource "aws_security_group" "memcached_sg" {
  name        = "memcached-sg"
  description = "memcached-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id


  ingress {
    description = "Memcached to Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  ingress {
    description = "Memcached to Mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  ingress {
    description = "Memcached to Rabbitmq"
    from_port   = 5672
    to_port     = 5672
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "memcached-sg"
  }
}

resource "aws_security_group" "rabbitmq_sg" {
  name        = "rabbitmq-sg"
  description = "rabbitmq-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id


  ingress {
    description = "rabbitmq to Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  ingress {
    description = "rabbitmq to Mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rabbitmq-sg"
  }
}

resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "mysql-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id


  ingress {
    description = "mysql to Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rabbitmq-sg"
  }
}


resource "aws_security_group" "elb_sg" {
  name        = "elb-sg"
  description = "elb-sg"
  vpc_id      = aws_vpc.vprofile_vpc.id


  ingress {
    description = "elb to Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  ingress {
    description = "http to elb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }

  ingress {
    description = "https to elb"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vprofile_vpc.cidr_block]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb-sg"
  }
}