provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet_1"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Subnet_2"
  }
}




# 2. Add the Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW"
  }
}

# 3. Route Table with Internet Route
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  # This route sends all outbound internet traffic to the IGW
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public-RouteTable"
  }
}

# 4. Associate Subnet 1 to the Public Route Table
resource "aws_route_table_association" "subnet_1_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public_rt.id
}

# 5. Associate Subnet 2 to the Public Route Table
resource "aws_route_table_association" "subnet_2_assoc" {
  subnet_id      = aws_subnet.secondary.id
  route_table_id = aws_route_table.public_rt.id
}
