resource "aws_instance" "main_ec2" {
    ami = "ami-0809dd5035d9217b8"
    instance_type = "t2.micro"
    tags = {
        Name = "main-ec2"
    }
    
}