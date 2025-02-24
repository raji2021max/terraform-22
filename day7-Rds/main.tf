
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  multi_az = "true"
  db_subnet_group_name   = aws_db_subnet_group.sub-grp.id
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  

}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycust"
  subnet_ids = ["subnet-0bf8354cb30ffb6b6","subnet-0edd0da55d13a739e"]

  tags = {
    Name = "My DB subnet group"
  }
}


