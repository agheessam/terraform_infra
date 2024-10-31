resource "aws_network_acl" "pvt_subnet_nacl" {
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
    cidr_block = "10.0.0.0/16" # allow all ssh
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
    cidr_block = "10.0.0.0/16" # allow all http request
  }

  tags = {
    Name = "main"
  }
}

resource "aws_network_acl_association" "pvt_nacl_association" {
  network_acl_id = aws_network_acl.pvt_subnet_nacl.id
  subnet_id      = aws_subnet.pvt_sub1.id  # Replace with your subnet resource
}