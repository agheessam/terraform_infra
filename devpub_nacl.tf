resource "aws_network_acl" "pub_subnet_nacl" {
  vpc_id = aws_vpc.Development.id
  
#outbound rule allow all tranffic
  egress {
    protocol   = "-1"
    rule_no    = 111
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

#inbound rule for ssh
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0" # allow all ssh
    from_port  = 22
    to_port    = 22
  }
  #inbound rule for http
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" # allow all http request
    from_port  = 80
    to_port    = 80
  }
    #inbound rule for icmp
  ingress {
    protocol   = "icmp"
    rule_no    = 95
    action     = "allow"
    cidr_block = "0.0.0.0/0" # allow all http request
  }

  tags = {
    Name = "main"
  }
}

resource "aws_network_acl_association" "pub_nacl_association1" {
  network_acl_id = aws_network_acl.pub_subnet_nacl.id
  subnet_id      = aws_subnet.pub_sub1.id  # Replace with your subnet resource
}
resource "aws_network_acl_association" "pub_nacl_association2" {
  network_acl_id = aws_network_acl.pub_subnet_nacl.id
  subnet_id      = aws_subnet.pub_sub2.id  # Replace with your subnet resource
}