resource "aws_spot_instance_request" "cheap_worker" {
  count                  = length(var.components)
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-000e3d77edcfc8e1f"]

  tags = {
    Name = element(var.components, count.index)
  }
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "^root*"
  owners      = ["973714476881"]
}

variable "components" {
  default = ["frontend", "mongodb", "catalogue", "cart", "user", "redis", "mysql", "shipping", "rabbitmq", "payment"]
}

provider "aws" {
  region = "us-east-1"
}