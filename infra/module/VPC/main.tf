/* Creation of VPC */

data "aws_region" "current_region" {}

/* VPC */
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name = var.vpc
  }
}

/* Subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  count      = 2

  tags = {
    name = "${var.public_subnet}-${count.index}"
  }
}

/* Route table */
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    name = var.route_table
  }
}

/* Internet gateway */
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    name = var.internet_gateway
  }
}

/* route table association */
resource "aws_route_table_association" "route_table_association" {
    count =  2
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id =  aws_route_table.route_table.id
}