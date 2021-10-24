locals {
  resources = {
    for node_group in aws_eks_node_group.eks_node_group :
    node_group.node_group_name => node_group.resources
  }
  asg_names = [
    for autoscaling_groups in local.resources :
    autoscaling_groups[0].autoscaling_groups[0].name
  ]
}
