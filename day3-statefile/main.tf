resource "aws_instance" "main"{
  ami = var.rora
  key_name = var.raji
  instance_type = var.rohith
}