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
}