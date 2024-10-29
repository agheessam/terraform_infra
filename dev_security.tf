
#define security group

resource "aws_security_group" "mysec" {
name = "dev_security_grp"
description = "Dev_security_grp"
vpc_id = aws_vpc.Development.id
}

# Ingress rule for SSH (port 22)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.mysec.id
  protocol          = "tcp"
  from_port        = 22
  to_port          = 22
  cidr_blocks       = ["0.0.0.0/0"]
}
# Ingress rule for SSH (http 80)
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
security_group_id = aws_security_group.mysec.id"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
# Egress rule allowing all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
security_group_id = aws_security_group.mysec.id
to_port = 0
from_port = 0
protocol = "-1" 
cidr_blocks = ["0.0.0.0/0"]
}