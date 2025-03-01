data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1"] # insert value here
  }
}






resource "aws_instance" "dev" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "2.micro"
   subnet_id =  data.aws_subnet.selected.id
    
}