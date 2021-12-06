resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_eks.id

  tags = {
    Name = "Public-Route"
  }
}

resource "aws_route_table" "private_rt_az1" {
  vpc_id = aws_vpc.vpc_eks.id

  tags = {
    Name = "Private-Route-AZ1"
  }
}

resource "aws_route_table" "private_rt_az2" {
  vpc_id = aws_vpc.vpc_eks.id

  tags = {
    Name = "Private-Route-AZ2"
  }
}

resource "aws_nat_gateway" "nat_az1" {
  allocation_id = aws_eip.eip_az1.id
  subnet_id     = aws_subnet.publicsubnet01.id

  tags = {
    Name = "Nat-AZ1"
  }
  depends_on = [aws_internet_gateway.igw, aws_eip.eip_az1]
}

resource "aws_nat_gateway" "nat_az2" {
  allocation_id = aws_eip.eip_az2.id
  subnet_id     = aws_subnet.publicsubnet02.id

  tags = {
    Name = "Nat-AZ2"
  }
  depends_on = [aws_internet_gateway.igw, aws_eip.eip_az2]
}

resource "aws_route" "pulic-route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway.igw]
}

resource "aws_route" "private-route-az1" {
  route_table_id         = aws_route_table.private_rt_az1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_az1.id
  depends_on             = [aws_nat_gateway.nat_az1]
}

resource "aws_route" "private-route-az2" {
  route_table_id         = aws_route_table.private_rt_az2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_az2.id
  depends_on             = [aws_nat_gateway.nat_az2]
}

resource "aws_route_table_association" "public_rt_assoc1" {
  subnet_id      = aws_subnet.publicsubnet01.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_assoc2" {
  subnet_id      = aws_subnet.publicsubnet02.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "private_rt_assoc_az1" {
  subnet_id      = aws_subnet.privatesubnet01.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "private_rt_assoc_az2" {
  subnet_id      = aws_subnet.privatesubnet02.id
  route_table_id = aws_route_table.private_rt_az2.id
}
