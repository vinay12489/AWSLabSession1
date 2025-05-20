resource "aws_vpc" "vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Vinay-VPC"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.1.0/24"
  tags = {
    Name = "public-subnet"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-south-1b"
  cidr_block        = "192.168.2.0/24"
  tags = {
    Name = "public-subnet-2"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "vinay_igw"
  }

}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

}
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id

}
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.rt.id

}
resource "aws_security_group" "SG" {
  name   = "Vinay_SG"
  vpc_id = aws_vpc.vpc.id
  ingress { # ssh
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress { # HHTP
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}