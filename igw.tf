resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_eks.id

  tags = {
    Name = "eks-igw"
  }
}
