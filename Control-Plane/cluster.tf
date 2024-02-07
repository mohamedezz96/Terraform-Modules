resource "aws_eks_cluster" "eks-cluster" {
  name                      = var.cluster_name
  version                   = var.cluster_version
  role_arn                  = aws_iam_role.eks_clutser_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = [aws_security_group.eks_control_node.id]
  }

  access_config {
    authentication_mode                         = var.auth_mode
    bootstrap_cluster_creator_admin_permissions = true
  }



  kubernetes_network_config {
    # The CIDR block to assign Kubernetes pod and service IP addresses from
    # Within one of the following private IP address blocks: 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16.
    # Doesn't overlap with any CIDR block assigned to the VPC that you selected for VPC.
    # Between /24 and /12.
    service_ipv4_cidr = var.cluster_ipv4_cidr

    # Valid values are ipv4 and ipv6
    ip_family = "ipv4"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.eks-cluster-logs,
    aws_security_group_rule.cluster_control_node_inbound,
    aws_security_group_rule.cluster_control_node_outbound_b,
  ]
}

