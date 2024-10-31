resource "aws_network_acl" "db_subnet_nacl" {
  vpc_id = aws_vpc.Development.id

  # Outbound rule: Allow all outbound traffic
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # Inbound rule: Allow SSH traffic from the private subnet
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.0.0/16"  # Replace with your private subnet CIDR
    from_port  = 22              # Allow SSH
    to_port    = 22              # Allow SSH
  }

  tags = {
    Name = "db_subnet_nacl"
  }
}
