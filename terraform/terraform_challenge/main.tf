

resource "aws_key_pair" "my_public_key" {
  key_name   = "terraform-key"
  public_key = file(var.my_key_location)

}


resource "aws_instance" "tomcat" {
  ami           = var.frontend_ami
  instance_type = var.aws_instance
  associate_public_ip_address = true
  key_name = aws_key_pair.my_public_key.key_name
  subnet_id = aws_subnet.us_east_1a_public.id
  security_groups = [aws_security_group.tomcat_sg.id]
  
  tags = {
    Name = "tomcat"
  }
}

resource "aws_instance" "memcached" {
  ami           = var.backend_ami
  instance_type = var.aws_instance
  subnet_id = aws_subnet.us_east_1a_private.id
  security_groups = [aws_security_group.memcached_sg.id]

  tags = {
    Name = "memcached"
  }
}

resource "aws_instance" "rabbitmq" {
  ami           = var.backend_ami
  instance_type = var.aws_instance
  subnet_id = aws_subnet.us_east_1a_private.id
  security_groups = [aws_security_group.rabbitmq_sg.id]

  tags = {
    Name = "rabbitmq"
  }
}

resource "aws_instance" "mysql" {
  ami           = var.backend_ami
  instance_type = var.aws_instance
  subnet_id = aws_subnet.us_east_1a_private.id
  security_groups = [aws_security_group.mysql_sg.id]

  tags = {
    Name = "mysql"
  }
}