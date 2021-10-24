###==========================================================================================
# creation of EKS cluster
###==========================================================================================
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.app_name}-${terraform.workspace}"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
