variable "vpc_id" {

}
variable "availability_zone" {}

variable "subnet_id" {}

variable "key_name" {
  description = "Name of the key pair to use for the EC2 instance"
  type        = string
}