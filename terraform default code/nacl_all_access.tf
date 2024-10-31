resource "aws_network_acl" "allow_all_nacl" {
  vpc_id = aws_vpc.Development.id

  # Allow all outbound traffic
  egress {
    protocol   = "-1"        # Allow all protocols
    rule_no    = 100         # Rule number (lower number = higher priority)
    action     = "allow"     # Allow action
    cidr_block = "0.0.0.0/0" # Allow all destinations
  }

  # Allow all inbound traffic
  ingress {
    protocol   = "-1"        # Allow all protocols
    rule_no    = 100         # Rule number (lower number = higher priority)
    action     = "allow"     # Allow action
    cidr_block = "0.0.0.0/0" # Allow all sources
  }

  tags = {
    Name = "AllowAllNACL"
  }
}

resource "aws_network_acl_association" "nacl_association" {
  network_acl_id = aws_network_acl.allow_all_nacl.id
  subnet_id      = aws_subnet.my_subnet.id  # Replace with your subnet resource
}