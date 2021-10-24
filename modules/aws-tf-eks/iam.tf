###==========================================================================================
# EKS Roles and Policies
###==========================================================================================
resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.app_name}-${terraform.workspace}-eks-cluster-role"
  assume_role_policy = templatefile("${path.module}/policies/assumerole-policy.json", { assume_resource = "eks.amazonaws.com" })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

###==========================================================================================
# EKS Node group Roles and Policies
###==========================================================================================
resource "aws_iam_role" "node_group_role" {
  name               = "${var.app_name}-${terraform.workspace}-eks-node-group"
  assume_role_policy = templatefile("${path.module}/policies/assumerole-policy.json", { assume_resource = "ec2.amazonaws.com" })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}

###==========================================================================================
# EKS Fargate Profile Roles and Policies
###==========================================================================================
resource "aws_iam_role" "fargate_profile_role" {
  name               = "${var.app_name}-${terraform.workspace}-eks-fargate-profile"
  assume_role_policy = templatefile("${path.module}/policies/assumerole-policy.json", { assume_resource = "eks-fargate-pods.amazonaws.com" })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_profile_role.name
}
