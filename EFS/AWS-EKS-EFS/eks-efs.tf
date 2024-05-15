resource "aws_security_group" "eks_efs_sg" {
  name        = "EFS-EKS-SG"
  description = "Allows Inbound NFS Traffic for your Amazon EFS mount points"
  vpc_id      = var.eks_cluster_vpc_id

  tags = {
    Name = "EFS-EKS-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_nfs_efs" {
  security_group_id = aws_security_group.eks_efs_sg.id
  cidr_ipv4         = data.aws_vpc.eks_cluster_vpc.cidr_block
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "tcp"
}

resource "aws_efs_file_system" "eks_efs_fs" {
  creation_token = "${var.eks_cluster_name}-Cluster-EFS"

  tags = {
    Name = "${var.eks_cluster_name}-Cluster-EFS"
  }
}

resource "aws_efs_mount_target" "eks_efs_mount_target" {
  count           = length(var.eks_workernode_subnets_id)
  file_system_id  = aws_efs_file_system.eks_efs_fs.id
  security_groups = [aws_security_group.eks_efs_sg.id]
  subnet_id       = var.eks_workernode_subnets_id[count.index]
}

