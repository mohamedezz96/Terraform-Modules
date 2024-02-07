resource "aws_security_group" "eks_control_node" {
  name        = "${var.cluster_name}-ControlPlane-sg"
  description = "Control Plane Nodes Security Group for allowing communications with Worker Nodes"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "cluster_control_node_inbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_control_node.id
  source_security_group_id = aws_security_group.eks_worker_node.id
  type                     = "ingress"
}
resource "aws_security_group_rule" "cluster_control_node_outbound" {
  description              = "Allow cluster API Server to communicate with the worker nodes on API server extension"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_control_node.id
  source_security_group_id = aws_security_group.eks_worker_node.id
  type                     = "egress"
}
resource "aws_security_group_rule" "cluster_control_node_outbound_b" {
  description              = "Allow cluster API Server to communicate with the worker nodes"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_control_node.id
  source_security_group_id = aws_security_group.eks_worker_node.id
  type                     = "egress"
}


resource "aws_security_group" "eks_worker_node" {
  name        = "${var.cluster_name}-WorkerNode-sg"
  description = "Worker nodes SG"
  vpc_id      = var.vpc_id

}

resource "aws_security_group_rule" "cluster_worker_node_inbound" {
  description              = "Allow cluster sec group to communicate with nodes"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "all"
  security_group_id        = aws_security_group.eks_worker_node.id
  source_security_group_id = aws_security_group.eks_worker_node.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_worker_node_outbound" {
  description              = "Allow node to communicate with cluster sec group"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "all"
  security_group_id        = aws_security_group.eks_worker_node.id
  source_security_group_id = aws_security_group.eks_worker_node.id
  type                     = "egress"
}

resource "aws_security_group_rule" "cluster_worker_node_inbound_b" {
  description              = "Allow API Server to communicate with kubelet"
  from_port                = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_node.id
  source_security_group_id = aws_security_group.eks_control_node.id
  to_port                  = 10250
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_worker_node_inbound_c" {
  description              = "Master to node on api server extension"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_node.id
  source_security_group_id = aws_security_group.eks_control_node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_worker_node_inbound_d" {
  description              = "Master to node for webhooks"
  from_port                = 1024
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_node.id
  source_security_group_id = aws_security_group.eks_control_node.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_worker_node_outbound_b" {
  description              = "Allow egress from nodes to master"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_node.id
  source_security_group_id = aws_security_group.eks_control_node.id
  type                     = "egress"
}

resource "aws_security_group_rule" "cluster_worker_node_outbound_c" {
  description       = "Allow egress from nodes to Public Internet"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_worker_node.id
  type              = "egress"
}