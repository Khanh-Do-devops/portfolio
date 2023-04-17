resource "aws_internet_gateway" "vprofile-igw" {
  vpc_id = aws_vpc.vprofile_vpc.id

  tags = {
    Name = "vprofile-igw"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.vprofile_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vprofile-igw.id
  }


  tags = {
    Name = "public-RT"
  }
}

resource "aws_route_table_association" "pub-1a" {
  subnet_id      = aws_subnet.us_east_1a_public.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "pub-1b" {
  subnet_id      = aws_subnet.us_east_1b_public.id
  route_table_id = aws_route_table.public_RT.id
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
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "pri-1b" {
  subnet_id      = aws_subnet.us_east_1b_private.id
  route_table_id = aws_route_table.public_RT.id
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