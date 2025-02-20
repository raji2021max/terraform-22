resource "aws_instance" "name2" {
  ami = "ami-053a45fff0a704a47"
  key_name = "empty"
  instance_type = "t2.micro"
}
