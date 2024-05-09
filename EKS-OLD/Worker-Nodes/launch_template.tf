resource "aws_launch_template" "eks_worker_node_template" {
  name                   = "${var.node_group_name}-template"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = var.disk_size
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
  vpc_security_group_ids = [var.worker_node_sg]
}