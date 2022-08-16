provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0ea5eb4b05645aa8a"
  instance_type          = "t3.micro"
  user_data              = <<-EOF
                  #!/bin/bash
                  echo "Hello, World" > index.html
                  nohup busybox httpd -f -p 8080 &
                  EOF
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    "Name" = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name        = "terraform-example-instance"
  description = "allow 8080 port to example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
