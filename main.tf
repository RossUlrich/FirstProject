provider "aws" {
  region = "us-east-1"
  access_key = "AKIARY5LIGX4QY76KR65"
  secret_key = "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"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "produftion"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_prefix[0]
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}


resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_prefix[1]
  availability_zone = "us-east-1a"

  tags = {
    Name = "dev-subnet"
  }
}

variable "subnet_prefix" {
#   type        = string
#   default     = ""
  description = "cird block for subnet"
}



resource "aws_internet_gateway" "I-G" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Internet_G"
  }
}


resource "aws_route_table" "Route_T" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.I-G.id
  }

  tags = {
    Name = "Rou_Table"
  }
}

# output "aws_subnet" {
#   value       = "aws_subnet.subnet_1.cidr_block"
# }



# resource "aws_eip" "Elastic_IP" {
#   vpc                 = true
#   network_interface   = aws_network_interface.network_interface.id
#   associate_with_private_ip = "172.16.1.99"
#   depends_on = [aws_internet_gateway.I-G]
# }

# resource "aws_network_interface" "network_interface" {
#   subnet_id   = aws_subnet.subnet-1.id
#   private_ips = ["172.16.1.100"]
#   security_groups = [aws_security_group.S-G]

#   # Assign the Elastic IP to the network interface
#   associate_public_ip_address = true
#   network_interface     = aws_network_interface.network_interface.id
#   associate_with_private_ip = "172.16.1.99"
# }


# resource "aws_instance" "Ubuntu_instance" {
#   ami           = "ami-053b0d53c279acc90"  # Ubuntu 20.04 LTS
#   instance_type = "t2.micro"
#   key_name      = "my-key-pair"

#   user_data = <<-EOF
#     #!/bin/bash
#     apt-get update
#     apt-get install -y apache2
#     systemctl enable apache2
#     systemctl start apache2
#   EOF
# }

# resource "aws_security_group" "example_security_group" {
#   name        = "example-security-group"
#   description = "Example security group for Apache"
# }






# resource "aws_instance" "my-first-server" {
#   ami           = "ami-0715c1897453cabd1"
#   instance_type = "t2.micro"
#     tags = {
#     # Name = "ubuntu"
#   }

  

# resource "<provider>_<resource_type>" "name" {
#    config options .....
#    key = "value"
#    key2 = "another"
# }