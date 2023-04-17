variable "aws_instance" {
    default = "t2.micro"
  
}

variable "frontend_ami" {
    default = "ami-0574da719dca65348"
  
}

variable "backend_ami" {
    default = "ami-0778521d914d23bc1"
  
}

variable "my_key_location" {
    default = "terraform-key.pub"
  
}
