provider "aws"  {
  region = "us-east-2"
  access_key = "AKIAT567BTQ3PFGZDKME"
  secret_key = "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"
}

# Creating VPC 
resource "aws_vpc" "manivpc" { 
 cidr_block = "192.168.0.0/16" 
  
tags = { 
 Name = "maniVPC"
} 
}

# Creating Internet Gateway
resource "aws_internet_gateway" "maniigw" {
 vpc_id = "${aws_vpc.manivpc.id}"
tags = {
 Name = "maniigw"
}
}


# Creating 1st web subnet
resource "aws_subnet" "public1" {
 vpc_id = "${aws_vpc.manivpc.id}"
 cidr_block = "192.168.100.0/24"
 map_public_ip_on_launch = true
 availability_zone = "us-east-2a"
tags = {
 Name = "public1"
}
}
# Creating 2nd web subnet
resource "aws_subnet" "public-2" {
 vpc_id = "${aws_vpc.manivpc.id}"
 cidr_block = "192.168.200.0/24"
 map_public_ip_on_launch = true
 availability_zone = "us-east-2b"
tags = {
 Name = "public-2"
}
}


# Creating Route Table
resource "aws_route_table" "route" {
 vpc_id = "${aws_vpc.manivpc.id}"
route {
 cidr_block = "0.0.0.0/0"
 gateway_id = "${aws_internet_gateway.maniigw.id}"
 }
tags = {
 Name = "Route to internet"
 }
}
# Associating Route Table
resource "aws_route_table_association" "rt1" {
 subnet_id = "${aws_subnet.public1.id}"
 route_table_id = "${aws_route_table.route.id}"
}
# Associating Route Table
resource "aws_route_table_association" "rt2" {
 subnet_id = "${aws_subnet.public-2.id}"
 route_table_id = "${aws_route_table.route.id}"
}


# Creating Security Group
resource "aws_security_group" "manisg" {
 vpc_id = "${aws_vpc.manivpc.id}"
# Inbound Rules
# HTTP access from anywhere
ingress {
 from_port = 80
 to_port = 80
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}
# HTTPS access from anywhere
ingress {
 from_port = 443
 to_port = 443
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}
# SSH access from anywhere
ingress {
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
}
# Outbound Rules
# Internet access to anywhere
egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
}
tags = {
 Name = "Web SG"
}
}

#Creating Key_pair to attach EC2 Instance
resource "aws_key_pair" "key_pair" {
  key_name   = "tests"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa"  {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key-pair" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "tests"
}

