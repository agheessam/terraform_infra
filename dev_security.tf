
#define security group
resource "aws_security_group" "mysec" {
  name        = "dev_security_grp"
  description = "Dev_security_grp"
  vpc_id      = aws_vpc.Development.id
  tags = {
    Name = "my_sec"
  }
}
# Ingress rule for SSH (port 22)

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.mysec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# Ingress rule for SSH (http 80)

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.mysec.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

# Egress rule allowing all outbound traffic

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
security_group_id = aws_security_group.mysec.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}



