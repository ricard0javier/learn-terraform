provider "aws" {
  version    = "~> 1.26"
  region     = "us-east-1"
  profile    = "tp-cts-intl-ps-ote-prod"
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}