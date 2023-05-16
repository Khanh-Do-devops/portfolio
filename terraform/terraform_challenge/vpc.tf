# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vprofile_vpc" {
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
  tags = {
    Name = "vprofile-VPC"

  }

}

# Creating 2 subnet. 1 in us-east 1a, and 1 in us-east-1b
resource "aws_subnet" "us_east_1a_public" {
  vpc_id            = aws_vpc.vprofile_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "us-east-1a-public"
  }
}

resource "aws_subnet" "us_east_1a_private" {
  vpc_id            = aws_vpc.vprofile_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "us-east-1a-private"
  }
}

resource "aws_subnet" "us_east_1b_public" {
  vpc_id            = aws_vpc.vprofile_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "us-east-1b-public"
  }
}

resource "aws_subnet" "us_east_1b_private" {
  vpc_id            = aws_vpc.vprofile_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "us-east-1b-private"
  }
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.vprofile_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vprofile_nat_gw.id
  }


  tags = {
    Name = "private-RT"
  }
}

resource "aws_route_table_association" "pri-1a" {
  subnet_id      = aws_subnet.us_east_1a_private.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_route_table_association" "pri-1b" {
  subnet_id      = aws_subnet.us_east_1b_private.id
  route_table_id = aws_route_table.private_RT.id
}

resource "aws_eip" "nat1" {
  depends_on = [aws_internet_gateway.vprofile-igw]

}

resource "aws_nat_gateway" "vprofile_nat_gw" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.us_east_1a_public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.vprofile-igw]
}
