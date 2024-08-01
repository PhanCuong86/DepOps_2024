resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    #Bật tính năng phân giải tên DNS cho các địa chỉ IP trong VPC
    enable_dns_hostnames = true
    tags = {
        "Name" = "vpc"
    }
}
#create Subnet private
resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet[count.index]
    availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
    #Instance 0: local.zone[0 % 3] -> ap-southeast-2a
    #Instance 1: local.zone[1 % 3] -> ap-southeast-2b
    tags = {
        "Name" = "private_subnet_${count.index}"
    }
}
#create Subnet Public
resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet)
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.public_subnet[count.index]
    availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
    tags = {
        "Name" = "public_subnet_${count.index}"
    }
}
#creater internet gateway
resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        "Name" = "ig"
    }
}
#Route table Public 
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id 
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }
    tags = {
        "Name" = "public"
    }
}
resource "aws_route_table_association" "public_association" {
    for_each = {
        for k, v in aws_subnet.public_subnet : k => v
    }
    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id
}
#Create elastic IP for NAT Gateway
resource "aws_eip" "nat" {
    domain   = "vpc"
}
resource "aws_nat_gateway" "public" {
    #Đảm bảo rằng Internet Gateway phải được tạo trước khi tạo NAT Gateway.
    depends_on = [aws_internet_gateway.ig]
    #Gán Elastic IP cho NAT Gateway.
    allocation_id = aws_eip.nat.id 
    subnet_id = aws_subnet.public_subnet[0].id
    tags = {
        Name = "public Nat"
    }
}
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.public.id
    }
    tags = {
        "Name" = "private"
    }
}
resource "aws_route_table_association" "public_private" {
    for_each = {
        for k, v in aws_subnet.private_subnet : k => v
    }
    subnet_id = each.value.id
    route_table_id = aws_route_table.private.id
}