#To launch server server using hardcode format


provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "MYAWSVM" {
  ami           = "ami-035827357e3c7e810"
  key_name      = "mumbai"
  instance_type = "t3.micro"

  security_groups = ["default"]

  tags = {
    Name = "MYEC2-VM"
  }
}
