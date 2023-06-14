terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

data "template_file" "script" {
  template = "${file("${path.module}/scripts/script.sh")}"
}

resource "aws_security_group" "mc_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft_server" {
  ami           = "ami-076bca9dd71a9a578"
  instance_type = "t2.small"
  key_name = "minecraftkey"  
  vpc_security_group_ids = [aws_security_group.mc_sg.id]
    
  user_data = "${data.template_file.script.rendered}" 

  tags = {
    Name = "minecraft_server"
  } 
}

output "public_ip" {
  value = aws_instance.minecraft_server.public_ip
}
