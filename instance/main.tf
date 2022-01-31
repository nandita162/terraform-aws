###### instance/main.tf #####

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
resource "aws_instance" "ec2-by-terraform" {
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id
  tags = {
    "Name" = "ec2-by-terraform"
  }
  subnet_id = var.private-subnet
}
