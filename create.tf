
# Main VPC Test

resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"


    tags = {
        Name = "Public Subnet"
    }
}

# Security group

resource "aws_security_group" "allow-ssh" {
  vpc_id      = "${aws_vpc.main_vpc.id}"
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "ig-main" {
    vpc_id = "${aws_vpc.main_vpc.id}"
}

# Route Table

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.ig-main.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

# Route table association

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}

# Web Server & Remote-Exec

resource "aws_instance" "web-1" {
    #instance = "${aws_instance.web-1.id}"
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    key_name = "project_2"
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/ankitchanpuriag/test_project/project_2.pem")
    # Default timeout is 5 minutes
    timeout     = "4m"
  }

# Remote file copy 

provisioner "file" {
    source      = "/home/ankitchanpuriag/test_project/id_rsa.pub"
    destination = "/home/ubuntu/id_rsa.pub"
  }

provisioner "file" {
    source      = "/home/ankitchanpuriag/test_project/id_rsa"
    destination = "/home/ubuntu/id_rsa"
  }

provisioner "file" {
    source      = "/home/ankitchanpuriag/test_project/shell_handler.sh"
    destination = "/home/ubuntu/shell_handler.sh"
  }


# Remote exec for executing commands 

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ubuntu/project_dir","chmod 777 /home/ubuntu/shell_handler.sh","sh /home/ubuntu/shell_handler.sh"
    ]
  }

}
