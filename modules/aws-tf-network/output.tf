###==========================================================================================
# Outputs of newtwoking
###==========================================================================================
output "pub_sub_ids" {
  value = local.pub_sub_ids
}

output "pri_sub_ids" {
  value = local.pri_sub_ids
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "azs" {
  value = local.az_names
}

# output "pub_subnets" {
#   value = aws_subnet.public
# }
