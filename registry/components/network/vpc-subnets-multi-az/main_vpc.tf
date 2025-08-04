# # # # # 
# VPC 
# # # # #
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = var.network_name
  }
}

# # # # # 
# Subnets  
# # # # #
resource "aws_subnet" "publics" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.extra_tags, {
    "Name" = "${var.network_name}-public-${count.index + 1}"
  })
}

resource "aws_subnet" "datas" {
  count                   = length(var.data_subnets)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = var.data_subnets[count.index]
  map_public_ip_on_launch = false

  tags = merge(var.extra_tags, {
    "Name" = "${var.network_name}-data-${count.index + 1}"
  })
}


resource "aws_subnet" "apps" {
  count                   = length(var.app_subnets)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = var.app_subnets[count.index]
  map_public_ip_on_launch = false

  tags = merge(var.extra_tags, {
    "Name" = "${var.network_name}-app-${count.index + 1}"
  })
}
