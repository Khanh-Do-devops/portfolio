variable "aws_instance" {
    default = "t2.micro"
  
}

variable "frontend_ami" {
    default = "ami-0729e439b6769d6ab"
  
}

variable "backend_ami" {
    default = "ami-002070d43b0a4f171"
  
}

variable "my_key_location" {
    default = "terraform-key.pub"
  
}

variable "tomcat_user_data" {
    default = "webapp.sh"
  
}

variable "mariadb_user_data" {
    default = "mariadb.sh"
  
}

variable "memcahed_user_data" {
    default = "memcached.sh"
  
}

variable "rabbitmq_user_data" {
    default = "rabbitmq.sh"
  
}