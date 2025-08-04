# # # # # 
# Internet Stuff
# # # # #
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.network_name}-igw"
  }
}

resource "aws_eip" "eip" {
  count = length(var.public_subnets)
  tags = merge(var.extra_tags, {
    "Name" = "${var.network_name}-eip-${count.index + 1}"
  })
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id

  tags = merge(var.extra_tags, {
    "Name" = "${var.network_name}-nat-${count.index + 1}"
  })
}
