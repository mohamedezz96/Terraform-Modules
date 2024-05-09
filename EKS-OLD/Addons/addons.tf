# vpc_cni addon
# retrieving version of vpc_cni addon related to our deployed eks version.
data "aws_eks_addon_version" "vpc_cni" {
  addon_name         = "vpc-cni"
  kubernetes_version = var.cluster_version
}
# Attaching the policy AmazonEKS_CNI_Policy to SA role which is requirements for vpc_cni addon
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = var.serviceaccount_role_name
}
# Creating vpc_cni addon
resource "aws_eks_addon" "vpc_cni" {
  cluster_name = var.cluster_name
  addon_name   = "vpc-cni"
  addon_version = data.aws_eks_addon_version.vpc_cni.version
}


# coredn addon
# Retrieving version of coredns addons related to our deployed eks version.
data "aws_eks_addon_version" "coredns" {
  addon_name         = "coredns"
  kubernetes_version = var.cluster_version
}
# Creating coredns addon.
resource "aws_eks_addon" "coredns" {
  cluster_name      = var.cluster_name
  addon_name        = "coredns"
  addon_version     = data.aws_eks_addon_version.coredns.version
}




# kube-proxy addon
# Retrieving version of kube-proxy addons related to our deployed eks version.
data "aws_eks_addon_version" "kube_proxy" {
  addon_name         = "kube-proxy"
  kubernetes_version = var.cluster_version
}
# Creating kube-proxy addon.
resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = var.cluster_name
  addon_name        = "kube-proxy"
  addon_version     = data.aws_eks_addon_version.kube_proxy.version
}

