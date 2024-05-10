resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.eks_vpc_private_subnet_ids

  ami_type = var.node_group_ami_type
  instance_types = var.node_group_instance_type
  capacity_type  = var.node_group_capacity_type

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  update_config {
    max_unavailable = var.node_group_max_unavailable
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_role_attachment1,
    aws_iam_role_policy_attachment.eks_node_group_role_attachment2,
    aws_iam_role_policy_attachment.eks_node_group_role_attachment3,
  ]
}