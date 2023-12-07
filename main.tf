provider "aws" {
  region = "us-west-1"  # Remplacez par la région de votre choix
}

variable "myname" {
  type    = string
  default = "Controlleur_takfarinas"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "aws_key_pair" "example" {
  key_name   = "${var.myname}-key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "privite_key" {
    filename = "${path.module}/${var.myname}-key.pem"
    content = tls_private_key.example.private_key_pem 
    file_permission = "0600"
}


resource "aws_security_group" "example" {
  name        = "${var.myname}-security-group"
  description = "Security group for SSH traffic"
  vpc_id = aws_vpc.takfa-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from any ip"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0cbd40f694b804622"  # Remplacez par une AMI appropriée
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
  security_groups = [aws_security_group.example.name]
  tags = {
    Name = var.myname
  }
}
resource "aws_vpc" "takfa-vpc" {
    cidr_block = "10.0.0.0/16"
}
