
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
        from_port = 443
        to_port = 443 
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
        from_port = 0
        to_port = 0
        protocol = "-1"
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
    subnet_id         = element(var.subnet_id, 0)
    security_groups   = [aws_security_group.ec2_sg.id]
    key_name = "cuong_key"
    tags = {
        Name = "main-ec2"
    }
}

resource "aws_key_pair" "cuong_key" {
    key_name = "cuong_key"
    public_key = tls_private_key.cuong_rsa.public_key_openssh
}
resource "tls_private_key" "cuong_rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}
resource "local_file" "file" {
    content = tls_private_key.cuong_rsa.private_key_pem
    filename = "cuong_key"
}