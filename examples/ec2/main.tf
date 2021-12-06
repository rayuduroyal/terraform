resource "aws_instance" "sample" {
  count                  = var.env == "prod" ? 1 : 0
  ami                    = data.aws_ami.example.id
  instance_type          = var.instance_type == "" ? "t3.micro" : var.instance_type
  vpc_security_group_ids = [var.SGID]

  tags = {
    Name = element(var.name, count.index)
  }
}

variable "SGID" {}
variable "name" {}

variable "instance_type" {}
variable "env" {}

data "aws_ami" "example" {
  most_recent = true
  name_regex  = "^Ubuntu*"
  owners      = ["973714476881"]
}

