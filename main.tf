terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
    region = "us-east-1"
 }
resource "aws_instance" "webserver" {
    ami = "ami-01bc990364452ab3e"
    availability_zone = "us-east-1a"
    instance_type = "t3.micro"
    key_name = "tf-kp"
    tags = {
        "Name" = "Webserver01"
        "project" = "rnd"
    }
    vpc_security_group_ids = [ aws_security_group.web-sg01.id ]
  
}

resource "aws_security_group" "web-sg01" {
  name = "Webserver SG"
  description = "SG for my webserver"

  ingress {
    description = "Allow port HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ports"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}