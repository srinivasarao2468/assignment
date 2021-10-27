###==========================================================================================
# EKS Node group resource
###==========================================================================================
resource "aws_eks_node_group" "eks_node_group" {
  for_each        = var.node_groups
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${each.key}-${terraform.workspace}"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.subnet_ids
  launch_template {
    id      = aws_launch_template.launch_template[each.key].id
    version = "$Latest"
  }
  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

###==========================================================================================
# Security grop for SSH Configuration for Node groups
###==========================================================================================
resource "aws_security_group" "eks_nodes_sg" {
  for_each    = var.node_groups
  name        = "${each.key}_${terraform.workspace}"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${each.key}_${terraform.workspace}"
  }
}
