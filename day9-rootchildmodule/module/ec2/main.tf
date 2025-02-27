resource "aws_instance" "this"{
  ami           = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"

  tags = {
    Name =" dev"
  }
}