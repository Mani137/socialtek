# Creating 1st EC2 instance in Public Subnet
resource "aws_instance" "maniinstance1" {
 ami = "ami-0568773882d492fc8"
 instance_type = "t2.micro"
 key_name = "tests"
 vpc_security_group_ids = ["${aws_security_group.manisg.id}"]
 subnet_id = "${aws_subnet.public-2.id}"
 associate_public_ip_address = true
 user_data = "${file("user1.sh")}"
tags = {
 Name = "maniinstance1"
}
}
# Creating 2nd EC2 instance in Public Subnet
resource "aws_instance" "maniinstance2" {
 ami = "ami-0568773882d492fc8"
 instance_type = "t2.micro"
 key_name = "tests"
 vpc_security_group_ids = ["${aws_security_group.manisg.id}"]
 subnet_id = "${aws_subnet.public-2.id}"
 associate_public_ip_address = true
 user_data = "${file("user2.sh")}"
tags = {
 Name = "maniinstance2"
}
}

