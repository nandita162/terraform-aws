##### vpc/main.tf #####

resource "aws_vpc" "VPC-by-terraform" {
  cidr_block = var.cidr
  tags = {
    "Name" = "VPC-by-terraform"
  }
}
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.VPC-by-terraform.id
  count = length(var.public_cidrs)
  cidr_block = var.public_cidrs[count.index]
  tags = {
    "Name" = "public-subnet${count.index + 1}"
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.VPC-by-terraform.id
  count = length(var.private_cidrs)
  cidr_block = var.private_cidrs[count.index]
  tags = {
    "Name" = "private-subnet${count.index + 1}"
  }
}
#resource "aws_security_group" "sg-by-terraform" {
#  name        = "public-sg"
#  description = "Security group for public access"
#  vpc_id      = aws_vpc.VPC-by-terraform.id
#  dynamic "ingress" {
#    from_port   = ingress.value.from
#    to_port     = ingress.value.to
#    protocol    = ingress.value.protocol
#    cidr_blocks = ingress.value.cidr_blocks
#  }
#  egress {
#    from_port   = 80
#    to_port     = 80
 #   protocol    = "tcp"
 #   cidr_blocks = ["0.0.0.0/0"]
 # }
#}
resource "aws_internet_gateway" "ig-by-terraform" {
  vpc_id = aws_vpc.VPC-by-terraform.id
  tags = {
    Name = "ig-by-terraform"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.VPC-by-terraform.id
  tags = {
    Name = "public_rt"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.VPC-by-terraform.id
  tags = {
    Name = "private_rt"
  }
}
resource "aws_route_table_association" "public_assoc" {
	count = length(var.public_cidrs)
  subnet_id = aws_subnet.public-subnet.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "private_assoc" {
	count = length(var.public_cidrs)
  subnet_id = aws_subnet.private-subnet.*.id[count.index]
  route_table_id = aws_route_table.private_rt.id
}