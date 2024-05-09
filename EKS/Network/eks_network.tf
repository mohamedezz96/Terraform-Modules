locals {
  first_public_subnet_az = keys(var.public_subnets_cidr_block)[0]
}
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_internet_gateway" "eks_vpc_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-vpc-igw"
  }
}

resource "aws_subnet" "eks_vpc_private_subnet" {
  for_each = var.private_subnets_cidr_block
  vpc_id            = aws_vpc.eks_vpc.id

  cidr_block        = each.value
  availability_zone = each.key 

  tags = {
    "Name"                            = "eks-private-subnet-${each.key}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}


resource "aws_subnet" "eks_vpc_public_subnet" {
  for_each = var.public_subnets_cidr_block
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "eks-public-subnet-${each.key}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}


resource "aws_eip" "eks_vpc_eip_nat_gateway" {
  domain = "vpc"

  tags = {
    Name = "eks-vpc-eip-nat-gateway"
  }
}

resource "aws_nat_gateway" "eks_vpc_nat_gateway" {
  allocation_id = aws_eip.eks_vpc_eip_nat_gateway.id
  subnet_id     = aws_subnet.eks_vpc_public_subnet[local.first_public_subnet_az].id

  tags = {
    Name = "eks-vpc-nat-gateway"
  }

  depends_on = [aws_internet_gateway.eks_vpc_igw]
}

resource "aws_route_table" "eks_vpc_private_subnet_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.eks_vpc_nat_gateway.id
    }
  

  tags = {
    Name = "eks-vpc-private-subnet-route-table"
  }
}

resource "aws_route_table" "eks_vpc_public_subnet_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.eks_vpc_igw.id
    }

  tags = {
    Name = "eks-vpc-public-subnet-route-table"
  }
}

resource "aws_route_table_association" "eks_vpc_private_subnet_association" {
  for_each       = aws_subnet.eks_vpc_private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.eks_vpc_private_subnet_route_table.id
}

resource "aws_route_table_association" "eks_vpc_public_subnet_association" {
  for_each       = aws_subnet.eks_vpc_public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.eks_vpc_public_subnet_route_table.id
}



