output "az" {
    value = aws_instance.name.availability_zone
  
}



output "public" {
    value = aws_instance.name.public_ip
    sensitive = true
  
}

output "region" {
  
}