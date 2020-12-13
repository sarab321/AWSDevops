resource "aws_vpc" "bmo_custom_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "bmo-custom-vpc-${var.environment}"
  }
}

resource "aws_subnet" "bmo_public_subnet" {
  vpc_id     = aws_vpc.bmo_custom_vpc.id
  cidr_block = var.public_subnet_cidr_block

  tags = {
    Name = "bmo-public-subnet-${var.environment}"
  }
}

resource "aws_subnet" "bmo_private_subnet" {
  vpc_id     = aws_vpc.bmo_custom_vpc.id
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Name = "bmo-private-subnet-${var.environment}"
  }
}

resource "aws_internet_gateway" "bmo_igw" {
  vpc_id = aws_vpc.bmo_custom_vpc.id

  tags = {
    Name = "bmo-igw-${var.environment}"
  }
}

resource "aws_route_table" "bmo_custom_rt" {
  vpc_id = aws_vpc.bmo_custom_vpc.id

  route {
    cidr_block = var.route_table_igw_cidr_block
    gateway_id = aws_internet_gateway.bmo_igw.id
  }

  tags = {
    Name = "bmo-custom-rt-${var.environment}"
  }
}
