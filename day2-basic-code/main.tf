resource "aws_instance" "name" {
  ami = var.ami_id
  key_name = var.keypair
  instance_type = var.instance_type
}