###==========================================================================================
# EKS fargate profile resource
###==========================================================================================
resource "aws_eks_fargate_profile" "fargate_profile" {
  for_each               = toset(var.fp_namespace)
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = "${each.key}-${terraform.workspace}"
  pod_execution_role_arn = aws_iam_role.fargate_profile_role.arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = each.key
    labels = {
      Name = each.key
    }
  }
}
