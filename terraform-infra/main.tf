provider "aws" {
  region = "eu-west-1"
}

# @component CalcApp:VPC (#vpc)
# Create VPC
resource "aws_vpc" "cyber94_bdeadfield_test_vpc" {
  cidr_block = "10.3.0.0/16"

  tags = {
    Name = "cyber94_bdeadfield_test_vpc"
  }
}

# Create Default Internet Gateway
resource "aws_internet_gateway" "cyber94_bdeadfield_test_ig" {
  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id

  tags = {
    Name = "cyber94_bdeadfield_test_ig"
  }
}

# Create Routing Table
resource "aws_route_table" "cyber94_bdeadfield_test_rt" {
  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cyber94_bdeadfield_test_ig.id
  }

  tags = {
    Name = "cyber94_bdeadfield_test_rt"
  }
}

# @component CalcApp:VPC:Subnet (#subnet)
# Create Subnets
resource "aws_subnet" "cyber94_bdeadfield_test_subnet_app" {
  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
  cidr_block = "10.3.1.0/24"

  tags = {
    Name = "cyber94_bdeadfield_test_subnet_app"
  }
}

resource "aws_subnet" "cyber94_bdeadfield_test_subnet_db" {
  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
  cidr_block = "10.3.2.0/24"

  tags = {
    Name = "cyber94_bdeadfield_test_subnet_db"
  }
}

resource "aws_subnet" "cyber94_bdeadfield_test_subnet_bastion" {
  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
  cidr_block = "10.3.3.0/24"

  tags = {
    Name = "cyber94_bdeadfield_test_subnet_bastion"
  }
}
# Create Route Table Association
resource "aws_route_table_association" "cyber94_bdeadfield_test_assoc_app" {
  subnet_id = aws_subnet.cyber94_bdeadfield_test_subnet_app.id
  route_table_id = aws_route_table.cyber94_bdeadfield_test_rt.id
}

resource "aws_route_table_association" "cyber94_bdeadfield_test_assoc_db" {
  subnet_id = aws_subnet.cyber94_bdeadfield_test_subnet_db.id
  route_table_id = aws_route_table.cyber94_bdeadfield_test_rt.id
}

resource "aws_route_table_association" "cyber94_bdeadfield_test_assoc_bastion" {
  subnet_id = aws_subnet.cyber94_bdeadfield_test_subnet_bastion.id
  route_table_id = aws_route_table.cyber94_bdeadfield_test_rt.id
}
# Create Network Access Control Lists
resource "aws_network_acl" "cyber94_bdeadfield_test_nacl_app" {
    vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
    subnet_ids = [aws_subnet.cyber94_bdeadfield_test_subnet_app.id]

    ingress {
      rule_no = 100
      from_port = 5000
      to_port = 5000
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    ingress {
      rule_no = 200
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    ingress {
      rule_no = 300
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 100
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 200
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 300
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 400
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    tags = {
      Name = "cyber94_bdeadfield_test_ncal_app"
    }
}

resource "aws_network_acl" "cyber94_bdeadfield_test_nacl_db" {
    vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
    subnet_ids = [aws_subnet.cyber94_bdeadfield_test_subnet_db.id]

    ingress {
      rule_no = 100
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    ingress {
      rule_no = 200
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 100
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    tags = {
      Name = "cyber94_bdeadfield_test_ncal_db"
    }
}

resource "aws_network_acl" "cyber94_bdeadfield_test_nacl_bastion" {
    vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id
    subnet_ids = [aws_subnet.cyber94_bdeadfield_test_subnet_bastion.id]

    ingress {
      rule_no = 100
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    ingress {
      rule_no = 200
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 100
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    egress {
      rule_no = 200
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
      action = "allow"
    }

    tags = {
      Name = "cyber94_bdeadfield_test_ncal_bastion"
    }
}
# Create Security Groups
resource "aws_security_group" "cyber94_bdeadfield_test_sg_app" {
  name = "cyber94_bdeadfield_test_sg_app"

  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cyber94_bdeadfield_test_sg_app"
  }
}

resource "aws_security_group" "cyber94_bdeadfield_test_sg_db" {
  name = "cyber94_bdeadfield_test_sg_db"

  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cyber94_bdeadfield_test_sg_db"
  }
}

resource "aws_security_group" "cyber94_bdeadfield_test_sg_bastion" {
  name = "cyber94_bdeadfield_test_sg_bastion"

  vpc_id = aws_vpc.cyber94_bdeadfield_test_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cyber94_bdeadfield_test_sg_bastion"
  }
}

# @component CalcApp:Web:Server (#web_server)
# @connects #subnet to #web_server with Network
# Create EC2 instances
resource "aws_instance" "cyber94_bdeadfield_test_server_app" {
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "cyber94-bdeadfield"
  subnet_id = aws_subnet.cyber94_bdeadfield_test_subnet_app.id
  vpc_security_group_ids = [aws_security_group.cyber94_bdeadfield_test_sg_app.id]
  associate_public_ip_address = true



  tags = {
    Name = "cyber94_bdeadfield_test_server_app"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "cyber94_bdeadfield_test_server_db" {
  ami = "ami-0d1c7c4de1f4cdc9a"
  instance_type = "t2.micro"
  key_name = "cyber94-bdeadfield"
  subnet_id = aws_subnet.cyber94_bdeadfield_test_subnet_db.id
  vpc_security_group_ids = [aws_security_group.cyber94_bdeadfield_test_sg_db.id]
  associate_public_ip_address = true

  tags = {
    Name = "cyber94_bdeadfield_test_server_db"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "cyber94_bdeadfield_test_server_bastion" {
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "cyber94-bdeadfield"
  subnet_id = aws_subnet.cyber94_bdeadfield_test_subnet_bastion.id
  vpc_security_group_ids = [aws_security_group.cyber94_bdeadfield_test_sg_bastion.id]
  associate_public_ip_address = true

  tags = {
    Name = "cyber94_bdeadfield_test_server_bastion"
  }

  lifecycle {
    create_before_destroy = true
  }
}
