resource "aws_subnet" "publicsubnet01" {
  vpc_id                  = aws_vpc.vpc_eks.id
  cidr_block              = "192.168.0.0/18"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "PublicSubnet01"
  }
}

resource "aws_subnet" "privatesubnet01" {
  vpc_id            = aws_vpc.vpc_eks.id
  cidr_block        = "192.168.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateSubnet01"
  }
}

resource "aws_subnet" "publicsubnet02" {
  vpc_id                  = aws_vpc.vpc_eks.id
  cidr_block              = "192.168.64.0/18"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "PublicSubnet02"
  }
}

resource "aws_subnet" "privatesubnet02" {
  vpc_id            = aws_vpc.vpc_eks.id
  cidr_block        = "192.168.192.0/18"
  availability_zone = "us-east-1b"

  tags = {
    Name = "PrivateSubnet02"
  }
}
