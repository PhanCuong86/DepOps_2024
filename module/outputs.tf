output "vpc" {
  value       = module.vpc.vpc_id
  description = "description"
  
}
output "public_subnet" {
    description = "List of IDs of public subnets"
    value = module.vpc.public_subnet
}
output "aws_internet_gateway" {
    description = "The ID of the Internet Gateway"
    value = module.vpc.aws_internet_gateway
}
output "private_subnet" {
    description = "List of IDs of private subnets"
    value = module.vpc.private_subnet
}
