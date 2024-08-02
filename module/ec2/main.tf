resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/rsa_demo.pub")
}

resource "aws_security_group" "ec2_sg" {
    name = "web-srv-sg"
    description = "Allow traffic ec2 connections"
    vpc_id = var.vpc_id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        "Name" = "allow_traffic_ec2_sg"
    }
}
resource "aws_instance" "main_ec2" {
    ami = "ami-0809dd5035d9217b8"
    instance_type = "t2.micro"
    subnet_id         = element(var.subnet_id, 0) # Lấy subnet đầu tiên từ danh sách
    availability_zone = element(var.availability_zone, 0) # Lấy availability zone đầu tiên từ danh sách
    security_groups   = [aws_security_group.ec2_sg.id] # Đưa vào danh sách
    key_name               = aws_key_pair.my_key_pair.key_name
    tags = {
        "Name" = "main_ec2"
    }
}
