resource "aws_instance" "import" {
    ami = "ami-05b10e08d247fb927"
    key_name = "empty"
    instance_type = "t2.micro"
    tags=  {
     name="fg"
    }
}