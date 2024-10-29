
#create database and security
#6.Create a MySQL engine based RDS database with the initial database name as PRT in the Production VPC.

resource "aws_security_group" "prod_sec" {
name = "prod_security_grp"
description = "prod_security_grp"
vpc_id = aws_vpc.Production.id
}

resource "aws_security_group_rule" "allow_db_access" {
  type              = "ingress"
  from_port         = 3306  # MySQL port
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.prod_sec.id  # Security group for RDS
  cidr_blocks       = ["10.0.0.0/16"]  # Replace with the CIDR block of the Development VPC
}

resource "aws_db_instance" "my_sqldb" {
  allocated_storage    = 10
  db_name              = "PRT"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin1234"
  parameter_group_name = "my_sqldb.mysql8.0"
  skip_final_snapshot  = true
}
