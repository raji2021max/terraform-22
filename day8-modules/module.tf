module "test" {
    source = "../day2-basic-codefor-modules"
    ami_id= "ami-053a45fff0a704a47"
    instance_type= "t2.micro"
    keypair = "empty"
  
}