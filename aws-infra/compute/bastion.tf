# TODO: Remove bastion
locals {
    base_init = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get upgrade -y
EOF
}

resource "aws_security_group" "bastion_sg" {
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ var.my_public_ip ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_instance" "bastion" {
    ami = var.ubuntu_ami_id
    instance_type = "t3.micro"
    subnet_id = var.public_subnet_id
    associate_public_ip_address = true
    user_data = local.base_init
    vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
    key_name = var.bastion_key_name

    tags = {
      "Name" = "Bastion"
    }
}
