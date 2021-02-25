terraform {
  required_version = ">= 0.14"
}

provider "aws" {
  shared_credentials_file = "C:\\Users\\Windows 10\\.aws\\credentials"
  region = "us-east-1"
  
}

resource "aws_instance" "example" {
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    Name = "terraform-example"
  }
}
resource "aws_security_group" "instance" {

  name = var.security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



