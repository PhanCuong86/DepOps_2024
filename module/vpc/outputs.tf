output "vpc_id" {
    description = "The ID of the vpc"
    value = aws_vpc.vpc.id 
}
output "aws_internet_gateway" {
    description = "The ID of the IGW"
    value = aws_internet_gateway.ig.id
}
output "public_subnet" {
    description = "List of IDs of public subnets"
    value = aws_subnet.public_subnet.*.id
}
output "private_subnet" {
    description = "List of IDs of private subnets"
    value = aws_subnet.private_subnet.*.id
}