
variable "myname-worker1" {
  type    = string
  default = "Worker1_takfarinas"
}

resource "aws_instance" "example1" {
  ami           = "ami-0cbd40f694b804622"  # Remplacez par une AMI appropriée
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
  security_groups = [aws_security_group.example.name]
  subnet_id       = aws_subnet.example.id
  tags = {
    Name = var.myname-worker1
  }
}
resource "aws_subnet" "example" {
vpc_id     = aws_vpc.takfa-vpc.id
cidr_block = "10.0.0.0/16"
tags = {
  Name = "example"
}
}
