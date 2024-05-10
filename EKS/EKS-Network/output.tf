output "eks_vpc_private_subnet_ids" {
  value = aws_subnet.eks_vpc_private_subnet[*].id
}
output "eks_vpc_public_subnet_ids" {
  value = [for subnet_key, subnet_value in aws_subnet.eks_vpc_public_subnet : subnet_value.id]
}

output "eks_vpc_subnet_ids" {
  value = concat(aws_subnet.eks_vpc_private_subnet[*].id, aws_subnet.eks_vpc_public_subnet[*].id)
}
