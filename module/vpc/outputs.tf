output "vpc_id" {
    description = "The ID of the vpc"
    value = aws_vpc.vpc.id 
}
output "aws_internet_gateway" {
    description = "The ID of the IGW"
    value = aws_internet_gateway.ig.id
}
