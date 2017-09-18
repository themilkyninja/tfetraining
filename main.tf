#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-1d4e7a66
#
# Your subnet ID is:
#
#     subnet-77f9d52d
#
# Your security group ID is:
#
#     sg-e72efe94
#
# Your Identity is:
#
#     terraform-jellyfish
#

terraform {
  backend "atlas" {
    name = "themilkyninja/training"
    #access_token = 
  }
}

variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "3"
  ami                    = "ami-1d4e7a66"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-77f9d52d"
  vpc_security_group_ids = ["sg-e72efe94"]

  tags {
    Identity = "terraform-jellyfish"

    SecretIdentity = "notajellyfish"

    SuperSecretIdentity = "shhh"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
