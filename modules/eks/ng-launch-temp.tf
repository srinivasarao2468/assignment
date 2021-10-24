###==========================================================================================
# EKS Node group key pair
###==========================================================================================
resource "aws_key_pair" "key_pair" {
  key_name   = "assignment"
  public_key = file("~/.ssh/id_rsa.pub")
}

###==========================================================================================
# EKS Node group launch template
###==========================================================================================
resource "aws_launch_template" "launch_template" {
  for_each      = var.node_groups
  name_prefix   = "eks-launchtemplate-${each.key}-${terraform.workspace}"
  description   = "Assignment Launch-Template"
  instance_type = each.value.instance_type
  key_name      = aws_key_pair.key_pair.key_name
}
