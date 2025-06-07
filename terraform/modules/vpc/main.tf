resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true 
  enable_dns_support = true
  tags = {
    Name = "project_vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.project_vpc.id
  availability_zone = "eu-west-2a"
  depends_on = [aws_vpc.project_vpc]
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "project_pub_sub1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.project_vpc.id
  availability_zone = "eu-west-2b"
  depends_on = [aws_vpc.project_vpc]
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "project_pub_sub2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.project_vpc.id
  availability_zone = "eu-west-2a"
  depends_on = [aws_vpc.project_vpc]
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "project_priv_sub1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.project_vpc.id
  availability_zone = "eu-west-2b"
  depends_on = [aws_vpc.project_vpc]
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "project_priv_sub2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project_vpc.id
  tags = {
    Name = "project_igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "project_rt"
  }
}

resource "aws_route_table_association" "pub_subnet1_route_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "pub_subnet2_route_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "project_nat" {
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.nat_eip.id
  tags = {
    Name = "project_nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "priv_route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.project_nat.id
  }
  tags = {
    Name = "project_private_rt"
  }
}

resource "aws_route_table_association" "private_subnet1_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.priv_route_table.id 
}

resource "aws_route_table_association" "private_subnet2_assoc" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.priv_route_table.id 
}
