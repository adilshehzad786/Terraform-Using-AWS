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
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example"
  }
}
resource "aws_security_group" "instance" {

  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



