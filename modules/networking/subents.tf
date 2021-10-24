###==========================================================================================
#  creation of Public subnet
###==========================================================================================
resource "aws_subnet" "public" {
  count                   = length(local.az_names)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = local.az_names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-public-subnet${count.index + 1}"
  }
}

###==========================================================================================
#  creation of route table for public subnet
###==========================================================================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-public-rt"
  }
}

###==========================================================================================
#  creation of route table associations for public subnet
###==========================================================================================
resource "aws_route_table_association" "pub_route_table_association" {
  count          = length(local.pub_sub_ids)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public.id
}

###==========================================================================================
#  creation of private subnets
###==========================================================================================
resource "aws_subnet" "private" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.az_names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + length(local.az_names))

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-private-subnet${count.index + 1}"
  }
}

###==========================================================================================
#  creation of private route table resouce for private subnets
###==========================================================================================
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-private-rt"
  }
}

###==========================================================================================
#  creation of route table associations for private subnets
###==========================================================================================
resource "aws_route_table_association" "pri_route_table_association" {
  count          = length(local.pri_sub_ids)
  subnet_id      = local.pri_sub_ids[count.index]
  route_table_id = aws_route_table.private.id
}
