resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
        "Name" = var.vpc_name
    }
}
resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet)
    vpc_id = aws_vpc.vpc.vpc_id
    cidr_block = var.private_subnet[count.index]
    availability_zone = var.availability_zone[count.index % lenght(var.availability_zone)]
    #Instance 0: local.zone[0 % 3] -> us-west-2a
    #Instance 1: local.zone[1 % 3] -> us-west-2b
    tags = {
        "Name" = "private_subnet"
    }
}
resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet)
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_subnet[count.index]
    availability_zone = var.availability_zone[count.index % lenght(var.availability_zone)]
    tags = {
        "Name" = "public_subnet"
    }
}
resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc
    tags = {
        "Name" = var.igname
    }
}
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
resource "aws_eip" "nat" {
    vpc = true
}
resource "aws_nat_gateway" "public" {
    depends_on = [aws_internet_gateway.ig]
    allocation = aws__eip.nat.id 
    subnet_id = aws_subnet.public_subnet[0].id
    tags = {
        Name = "public Nat"
    }
}