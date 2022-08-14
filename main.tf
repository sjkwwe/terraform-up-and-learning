provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "name" {
    ami = "ami-0ea5eb4b05645aa8a"
    instance_type = "t3.micro"
    tags = {
      "Name" = "terraform-example"
    }
}