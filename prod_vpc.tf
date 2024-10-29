#VPC production
#5.	Create a custom VPC (Name: Production) and 2 Public subnets and 1 Private subnet in different AZs in the North Virginia region.

resource "aws_vpc" "Production" {

cidr_block = "10.10.0.0/16"
instance_tenancy = "default"

tags = {
Name = "Production"
}
}

resource "aws_subnet" "pub_sub1" {
vpc_id = aws_vpc.Production.id
cidr_block = "10.10.1.0/24"
availability_zone = "us-east-1a"
tags = {
Name = "pub_sub1"
}
}

resource "aws_subnet" "pub_sub2" {
vpc_id = aws_vpc.Production.id
cidr_block = "10.10.2.0/24"
availability_zone = "us-east-1b"
tags = {
Name = "pub_sub2"
}
}

resource "aws_subnet" "pvt_sub1" {
vpc_id = aws_vpc.Production.id
cidr_block = "10.10.3.0/24"
availability_zone = "us-east-1c"
tags = {
Name = "pvt_sub1"
}
}

resource "aws_route_table" "prodpvt_route" {
  vpc_id = aws_vpc.Development.id

  route {
    cidr_block = "0.0.0.0/0"
  } 
}
resource "aws_route_table_association" "assoc_prodpvt1" {
  subnet_id      = aws_subnet.pvt_sub1.id
  route_table_id = aws_route_table.pub_route.id
}