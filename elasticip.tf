/*
resource "aws_network_interface" "nic_az1" {
  subnet_id = aws_subnet.publicsubnet01.id
}

resource "aws_network_interface" "nic_az2" {
  subnet_id = aws_subnet.publicsubnet02.id
}
*/

resource "aws_eip" "eip_az1" {
  vpc = true
  #subnet_id = aws_subnet.publicsubnet01.id
}

resource "aws_eip" "eip_az2" {
  vpc = true
  #network_interface = aws_subnet.publicsubnet02.id
}
