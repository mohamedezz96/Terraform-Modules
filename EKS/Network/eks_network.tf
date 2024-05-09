resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"

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

resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.0.0/19" # 10.0.0.0 - 10.0.31.255 (10.0.0.0 & 10.0.0.1 & 10.0.0.2 & 10.0.0.4 & 10.0.31.255 reserved) 
  availability_zone = "us-east-1a"

  tags = {
    "Name"                            = "eks-private-subnet-us-east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.32.0/19" # 10.0.32.0 - 10.0.63.255 (10.0.32.0 & 10.0.32.1 & 10.0.32.2 & 10.0.32.3 & 10.0.63.255 reserved)
  availability_zone = "us-east-1b"

  tags = {
    "Name"                            = "eks-private-subnet-us-east-1b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.64.0/19" # 10.0.64.0 - 10.0.95.255 (10.0.64.0 & 10.0.64.1 & 10.0.64.2 & 10.0.64.3 & 10.0.95.255 reserved)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "eks-public-subnet-us-east-1a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.96.0/19" # 10.0.96.0 - 	10.0.127.255 (10.0.96.0 & 10.0.96.1 & 10.0.96.2 & 10.0.96.3 & 10.0.127.255 reserved)
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "eks-public-subnet-us-east-1b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}


resource "aws_eip" "eip_nat_gateway" {
  domain = "vpc"

  tags = {
    Name = "eip-nat-gateway"
  }
}

resource "aws_nat_gateway" "eks-nat-gateway" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "eks-nat-gateway"
  }

  depends_on = [aws_internet_gateway.eks_vpc_igw]
}

resource "aws_route_table" "private-subnet-route-table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.eks-nat-gateway.id
    }
  

  tags = {
    Name = "eks-private-subnet-route-table"
  }
}

resource "aws_route_table" "public-subnet-route-table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.eks_vpc_igw.id
    }

  tags = {
    Name = "eks-public-subnet-route-table"
  }
}

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private-subnet-route-table.id
}

resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.public-subnet-route-table.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.public-subnet-route-table.id
}

