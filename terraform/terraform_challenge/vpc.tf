# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vprofile_vpc" {
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"

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
