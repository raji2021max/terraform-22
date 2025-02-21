resource "aws_instance" "public" {
    ami = "ami-053a45fff0a704a47"
    instance_type = "t2.micro"
    key_name = "empty"
    
  
}
#create VPC
resource "aws_vpc" "rora"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Dev VPC"
    } 
}
#create IG and attach to VPC
resource "aws_internet_gateway" "rora" {
    vpc_id = aws_vpc.rora.id
  
}

#create subnets

resource "aws_subnet" "rora" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.rora.id
    map_public_ip_on_launch = true
  
}

#create route table and provide path IG to RT (edit routes)
resource "aws_route_table" "rora" {
    vpc_id = aws_vpc.rora.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rora.id
    
  }
  
}
#associate  RT to subnet
resource "aws_route_table_association" "rora" {
    route_table_id = aws_route_table.rora.id
    subnet_id = aws_subnet.rora.id
    
  
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.rora.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }


  }

  

# Create a private subnet 
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.rora.id
  cidr_block              = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}

# Allocate an Elastic IP 
resource "aws_eip" "nat_eip" {

}

 #Create a NAT Gateway in the public subnet
resource "aws_nat_gateway" "nat_gat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.rora.id
  tags = {
    Name = "nat-gateway"
  }
}

 #Create a route table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.rora.id
  tags = {
    Name = "private-route-table"
  }
}

# Create a route in the private route table to the NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gat.id
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_instance" "private" {
  ami="ami-053a45fff0a704a47"
  instance_type = "t2.micro"
  key_name = "empty"
  subnet_id     = aws_subnet.private_subnet.id
  associate_public_ip_address = false 

}