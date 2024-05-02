data "aws_vpc" "eks_vpc" {
  count = var.create_efs ? 1:0
  id = var.eks_vpc_id
}

resource "aws_security_group" "efs_sg" {
  count = var.create_efs ? 1:0
  name        = "EFS-SecurityGroup"
  description = "Allow Inbound NFS traffic for your Amazon EFS mount points"
  vpc_id      = var.eks_vpc_id

  tags = {
    Name = "EFS-SecurityGroup"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_efs_ingress" {
  count = var.create_efs ? 1:0
  security_group_id = aws_security_group.efs_sg.id
  cidr_ipv4         = data.aws_vpc.eks_vpc.cidr_block
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "tcp"
  
}


resource "aws_efs_file_system" "eks_efs" {
  count = var.create_efs ? 1:0
  creation_token = "EKS-${var.cluster_name}-EFS"

  tags = {
    Name = "EKS-${var.cluster_name}-EFS"
  }
}

resource "aws_efs_mount_target" "eks_worker_node_efs" {
  count = var.create_efs ? 1:0
  for_each = var.eks_worker_node_subnets

  file_system_id = aws_efs_file_system.eks_efs.id
  subnet_id      = each.value
}
