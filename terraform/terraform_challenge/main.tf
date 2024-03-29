resource "aws_key_pair" "my_public_key" {
  key_name   = "terraform-key"
  public_key = file(var.my_key_location)

}

resource "aws_instance" "memcached" {
  ami             = var.backend_ami
  instance_type   = var.aws_instance
  subnet_id       = aws_subnet.us_east_1a_private.id
  security_groups = [aws_security_group.memcached_sg.id]
  key_name        = aws_key_pair.my_public_key.key_name
  user_data       = file(var.memcahed_user_data)

  tags = {
    Name = "memcached"
  }
}

resource "aws_instance" "rabbitmq" {
  ami             = var.backend_ami
  instance_type   = var.aws_instance
  subnet_id       = aws_subnet.us_east_1a_private.id
  security_groups = [aws_security_group.rabbitmq_sg.id]
  key_name        = aws_key_pair.my_public_key.key_name
  user_data       = file(var.rabbitmq_user_data)

  tags = {
    Name = "rabbitmq"
  }
}

resource "aws_instance" "mysql" {
  ami                  = var.backend_ami
  instance_type        = var.aws_instance
  subnet_id            = aws_subnet.us_east_1a_private.id
  security_groups      = [aws_security_group.mysql_sg.id]
  key_name             = aws_key_pair.my_public_key.key_name
  user_data            = local.policy
  iam_instance_profile = aws_iam_instance_profile.SM_role_permission_profile.name


  tags = {
    Name = "mysql"
  }
}

resource "aws_iam_instance_profile" "SM_role_permission_profile" {
  name = "SM_role_permission_profile"
  role = aws_iam_role.SecretRead_role.name
}
