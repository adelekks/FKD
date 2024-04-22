# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "ken-mac"
  public_key = "${file("${var.key_path}")}"
}

# Define bitbucket-server inside the public subnet
resource "aws_instance" "bitbucket" {
   ami  = "${var.ami}"
#   instance_type = "t2.medium"
   instance_type = "t2.micro"
#   size           = 40
#   key_name = "Kenny-mac"
   key_name = "${aws_key_pair.default.id}"   
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgbitbucket.id}"]
   associate_public_ip_address = true
   source_dest_check = false


   tags = {
     Name = "bitbucket-server"
  }
}
# Define jenkins-server inside the public subnet
resource "aws_instance" "jenkins" {
   ami  = "${var.ami}"
#   instance_type = "t2.medium"
#   size           = 40
   instance_type = "t2.micro"
#   key_name = "Kenny-mac"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
   associate_public_ip_address = true
   source_dest_check = false

   tags = {
     Name = "jenkins-server"
  }
}
# Define nexus-server inside the public subnet
resource "aws_instance" "nexus" {
   ami  = "${var.ami}"
#   instance_type = "t2.medium"
#   size           = 40
   instance_type = "t2.micro"
#   key_name = "Kenny-mac"
   key_name = "${aws_key_pair.default.id}"   
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgnexus.id}"]
   associate_public_ip_address = true
   source_dest_check = false

  tags = {
    Name = "nexus-server"
  }
}
# Define sonarqube-server inside the public subnet
resource "aws_instance" "sonarqube" {
   ami  = "${var.ami}"
#   instance_type = "t2.medium"
#   size           = 40
   instance_type = "t2.micro"
#   key_name = "Kenny-mac"
   key_name = "${aws_key_pair.default.id}"   
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgnexus.id}"]
   associate_public_ip_address = true
   source_dest_check = false
    
  tags = {
    Name = "sonarqube-server"
  }
}
