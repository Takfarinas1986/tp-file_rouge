
variable "myname-worker2" {
  type    = string
  default = "Worker2_takfarinas"
}

resource "aws_instance" "example2" {
  ami           = "ami-0cbd40f694b804622"  # Remplacez par une AMI appropriée
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
  security_groups = [aws_security_group.example.name]
  subnet_id       = aws_subnet.example.id
  tags = {
    Name = var.myname-worker2
  }
}


