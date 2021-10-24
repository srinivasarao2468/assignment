###==========================================================================================
# Outputs of EKS
###==========================================================================================

output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_node_group" {
  value = aws_eks_node_group.eks_node_group
}

# output "eks_node_group_resources" {
#   value = aws_eks_node_group.eks_node_group.resources
# }

output "asg_names" {
  value = local.asg_names
}
