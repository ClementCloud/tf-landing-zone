resource "aws_vpc" "landing_zone_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  cidr_block              = "10.0.${count.index}.0/24"
  vpc_id                  = aws_vpc.landing_zone_vpc.id
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  count             = 2
  cidr_block        = "10.0.${count.index + 10}.0/24"
  vpc_id            = aws_vpc.landing_zone_vpc.id
  availability_zone = "us-west-2a"
}

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow inbound traffic to public resources"
  vpc_id      = aws_vpc.landing_zone_vpc.id


}

resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow traffic within the VPC"
  vpc_id      = aws_vpc.landing_zone_vpc.id
}

resource "aws_instance" "ec2_instance" {
  ami             = "ami-002829755fa238bfa"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet[0].id
  security_groups = [aws_security_group.private_sg.id]
}


resource "aws_s3_bucket" "cjbucket" {
  bucket = "cjtestbucket072923"

}

resource "aws_s3_bucket" "cjbucket2" {
  bucket = "cjtestbucket-082523"

}
