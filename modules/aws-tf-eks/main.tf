###==========================================================================================
# creation of EKS cluster
###==========================================================================================
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.app_name}-${terraform.workspace}"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
   enabled_cluster_log_types = ["api", "audit"]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.eks_cloudwatch_log_group
  ]
  tags = var.tags
}

###==========================================================================================
# creation of EKS cluster
###==========================================================================================
resource "aws_cloudwatch_log_group" "eks_cloudwatch_log_group" {
  name              = "/aws/eks/${var.app_name}-${terraform.workspace}/cluster"
  retention_in_days = 7
}
