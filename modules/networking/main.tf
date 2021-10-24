###==========================================================================================
# Creation of VPC
###==========================================================================================
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_config.cidr_block
  instance_tenancy = var.vpc_config.instance_tenancy
  tags             = var.vpc_config.tags
}

###==========================================================================================
#  creation of internet gateway
###==========================================================================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-${terraform.workspace}-igw"
  }
}

###==========================================================================================
#  creation of eip for nat gateway
###==========================================================================================
resource "aws_eip" "nat" {
  vpc = true
}

###==========================================================================================
#  creation of nat gateway
###==========================================================================================
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = local.pub_sub_ids[0]

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-nat-gateway"
  }
  depends_on = [aws_internet_gateway.igw]
}
