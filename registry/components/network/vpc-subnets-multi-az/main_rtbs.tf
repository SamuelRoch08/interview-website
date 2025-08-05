# # # # # 
# Public Routing  
# # # # #
resource "aws_route_table" "publics_rtb" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.extra_tags, {
    Name = "${var.network_name}-public-rtb"
  })
}

resource "aws_route_table_association" "public_rtb" {
  count          = length(aws_subnet.publics)
  subnet_id      = aws_subnet.publics[count.index].id
  route_table_id = aws_route_table.publics_rtb.id
}

# # # # # 
# Data Routing  
# # # # #
resource "aws_route_table" "data_rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.extra_tags, {
    Name = "${var.network_name}-data-rtb"
  })
}

resource "aws_route_table_association" "data_rtb" {
  count          = length(var.data_subnets)
  subnet_id      = aws_subnet.datas[count.index].id
  route_table_id = aws_route_table.data_rtb.id
}

# # # # # 
# App Routing  
# # # # #
resource "aws_route_table" "app_rtb" {
  count  = length(var.app_subnets)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = merge(var.extra_tags, {
    Name = "${var.network_name}-app-rtb-${count.index + 1}"
  })
}

resource "aws_route_table_association" "app_rtb" {
  count          = length(var.app_subnets)
  subnet_id      = aws_subnet.apps[count.index].id
  route_table_id = aws_route_table.app_rtb[count.index].id
}