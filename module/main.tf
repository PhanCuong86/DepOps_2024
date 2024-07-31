provider "aws" {
  region     = "ap-southeast-2"
}
/* # Maintain the statefile in s3
terraform {
  backend "s3" {
    region  = "ap-southeast-2"
    encrypt = true
  }
}
*/
module "vpc" {
  source = "./vpc"
  vpc_cidr_block = "10.0.0.0/16"
  private_subnet = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnet  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zone = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}
