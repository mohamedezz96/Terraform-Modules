resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.eks_vpc_private_subnet_ids

  ami_type = "BOTTLEROCKET_x86_64"
  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_role_attachment1,
    aws_iam_role_policy_attachment.eks_node_group_role_attachment2,
    aws_iam_role_policy_attachment.eks_node_group_role_attachment3,
  ]
}