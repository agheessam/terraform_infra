#2.	Launch an instance in each subnet (Name: Public1, Public2, Private1) with Amazon Linux, Ubuntu, RedHat AMIs respectively.
#3.	Install web server in all instances and change the default webpage of the web server with their Private IP being displayed.

#instance with webapp

resource "aws_instance" "Public1" {
  ami                     = "ami-06b21ccaeff8cd686"    #amazon linux
  instance_type           = "t2.micro"
   subnet_id     = aws_subnet.pub_sub1.id
   security_groups = [aws_security_group.mysec.name]
    key_name = "key3"
   user_data = <<-EOF
                   #!/bin/bash
				   yum update -y
				   yum install -y httpd
				   echo "<html><body><h1>Your private ip : $(hostname -I | awk '{print $1}')</h1></body></html>" > /var/www/html/index.html
				   systemctl start httpd
				   systemctl enable httpd
				   EOF
   tags = {
    Name = "Public1"
  }
}

resource "aws_instance" "Public2" {
  ami                     = "ami-0866a3c8686eaeeba"   #Ubuntu
  instance_type           = "t2.micro"
   subnet_id     = aws_subnet.pub_sub2.id
   security_groups = [aws_security_group.mysec.name]
   key_name = "key3"
   user_data = <<-EOF
                    #!/bin/bash
					apt-get update -y
					apt install -y apache2
					echo "<html><body><h1>Your private ip is : $(hostname -I | awk '{print $1}')</h1></body></html>" > /var/www/html/index.html
					systemctl start apache2
					systemctl enable apache2
					EOF
						
    tags = {
    Name = "Public2"
  }
}

resource "aws_instance" "Private1" {
  ami                     = "ami-0583d8c7a9c35822c"  # RedHat
  instance_type           = "t2.micro"
   subnet_id     = aws_subnet.pvt_sub1.id
   security_groups = [aws_security_group.mysec.name]
    key_name = "key3"
   user_data = <<-EOF
                    #!/bin/bash
					yum update -y
					yum install -y httpd
					echo "<html><body><h1>your ip address  is : $(hostname -I | awk '{print $1}')</h1></body></html>" > /var/www/html/index.html
				    systemctl start httpd
					systemctl enable httpd
					EOF
       tags = {
    Name = "Private1"
  }
}