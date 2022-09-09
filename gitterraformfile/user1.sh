#!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo yum -y install git
  sudo git clone https://github.com/Akiranred/candy-crush.git /var/www/html/index.html

